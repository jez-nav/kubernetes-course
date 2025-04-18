# Appendix C: Troubleshooting Guide

Despite careful planning, issues inevitably arise when working with complex systems like Kubernetes and Terraform. This appendix provides a starting point for diagnosing common problems.

## Common Kubernetes Issues and Debugging Steps

The `kubectl` command-line tool is your primary weapon for troubleshooting Kubernetes issues.

**1. Pod Status Issues:**

*   **`Pending`:** The Pod cannot be scheduled onto a node.
    *   **Check Events:** `kubectl describe pod <pod-name> -n <namespace>` - Look at the `Events` section at the bottom. Common reasons include:
        *   Insufficient Resources: "Insufficient cpu", "Insufficient memory". Check node capacity (`kubectl describe node <node-name>`) and Pod requests (`kubectl get pod <pod-name> -o yaml`). Solution: Add nodes, increase node size, reduce Pod requests, or use Cluster Autoscaler.
        *   Node Affinity/Anti-Affinity/Taints: Pod scheduling constraints prevent it from landing on available nodes. Check `nodeSelector`, `affinity` rules in Pod spec, and node `taints` (`kubectl describe node <node-name>`). Solution: Adjust constraints or node labels/taints.
        *   Volume Mounting Issues: "FailedMount", "AttachVolume.Attach failed". Often related to PersistentVolume availability or access modes (e.g., trying to mount RWO volume on multiple nodes). Check PV/PVC status (`kubectl get pv,pvc`), StorageClass, and CSI driver logs.
    *   **Check Scheduler Logs:** (Cluster Admin) View logs for the `kube-scheduler` Pod in the `kube-system` namespace.
*   **`ImagePullBackOff` / `ErrImagePull`:** Kubelet cannot pull the container image.
    *   **Check Image Name/Tag:** `kubectl describe pod <pod-name> -n <namespace>` - Verify the `Image:` field is correct (registry, repository, tag).
    *   **Check Registry Access:** Can the node access the registry? Is authentication required?
    *   **Check ImagePullSecrets:** If using a private registry, ensure the Pod spec includes the correct `imagePullSecrets` and that the referenced Secret exists and contains valid credentials (`kubectl get secret <secret-name> -o yaml`).
    *   **Check Network:** Can the node resolve DNS for the registry? Are there firewall rules blocking access?
    *   **Check Node Disk Space:** Insufficient disk space on the node can sometimes cause image pull failures.
*   **`CrashLoopBackOff`:** The container starts, crashes, and Kubernetes keeps restarting it.
    *   **Check Logs:** `kubectl logs <pod-name> -n <namespace> [-c <container-name>]` - Look for application errors immediately before the crash.
    *   **Check Previous Logs:** `kubectl logs <pod-name> -n <namespace> --previous` - View logs from the *previous* terminated instance of the container, which often contains the original error.
    *   **Check Liveness Probe:** `kubectl describe pod ...` - Is a liveness probe failing and causing restarts? Check probe configuration and application health endpoint. Temporarily remove the probe to see if the container runs.
    *   **Check Resource Limits:** Is the container exceeding its memory limit and getting OOMKilled? `kubectl describe pod ...` might show `Reason: OOMKilled`. Increase memory limits.
    *   **Check Command/Args:** `kubectl get pod ... -o yaml` - Verify the container's `command` and `args` are correct.
    *   **Exec into Container (if possible):** If the container runs briefly, try `kubectl exec -it ... -- sh` to explore the filesystem or run diagnostic commands.
*   **`Terminating` (Stuck):** Pod is stuck trying to shut down.
    *   **Check `terminationGracePeriodSeconds`:** Is it set too long?
    *   **Check Finalizers:** `kubectl get pod <pod-name> -o yaml` - Look for `metadata.finalizers`. Sometimes custom controllers add finalizers that prevent deletion until an external condition is met. The controller might be malfunctioning. Manual removal of finalizers (`kubectl patch pod ...`) is risky but sometimes necessary.
    *   **Check Node Status:** Is the node unresponsive?
    *   **Force Delete (Last Resort):** `kubectl delete pod <pod-name> --grace-period=0 --force` - Use with extreme caution, especially for StatefulSet Pods, as it can lead to issues if the Pod was still accessing storage.

**2. Service/Networking Issues:**

*   **Cannot Connect to Service:**
    *   **Check Service Definition:** `kubectl get svc <service-name> -o yaml` - Verify `selector` matches the labels on your backend Pods. Check `ports` and `targetPort` match the container port.
    *   **Check Pod Labels:** `kubectl get pods --show-labels` - Ensure backend Pods have the correct labels matching the Service selector.
    *   **Check Endpoints:** `kubectl get endpoints <service-name>` - Does the Endpoints object list the IP addresses of your healthy backend Pods? If empty or incorrect, check Pod labels and readiness probes.
    *   **Check Pod Readiness:** Are the backend Pods `READY` (`kubectl get pods`)? If not, traffic won't be sent to them. Check readiness probes (`kubectl describe pod`).
    *   **Check Network Policies:** `kubectl get networkpolicy -n <namespace>` - Are there NetworkPolicies blocking traffic between the client Pod and the Service/backend Pods?
    *   **Check DNS Resolution:** From a client Pod (`kubectl exec -it <client-pod> -- sh`), try `nslookup <service-name>.<namespace>.svc.cluster.local`. Does it resolve to the ClusterIP? Check CoreDNS logs (`kubectl logs -n kube-system -l k8s-app=kube-dns`).
    *   **Check kube-proxy:** (Cluster Admin) Check `kube-proxy` logs on the relevant nodes. Verify iptables/IPVS rules are correctly configured (`iptables-save | grep <service-ip>`).
*   **Cannot Access NodePort/LoadBalancer:**
    *   Verify Service `type` is `NodePort` or `LoadBalancer`.
    *   Check `kubectl get svc <service-name>` - Is the `EXTERNAL-IP` assigned (for LoadBalancer)? Is the `NODEPORT` listed?
    *   Check Cloud Provider Load Balancer: Is the external LB healthy and configured correctly? Are firewall/security group rules allowing traffic from your IP to the NodePort range on the nodes?
    *   Check Node Health: Are the cluster nodes healthy?

**3. General Debugging Commands:**

*   `kubectl get events --sort-by='.lastTimestamp'`: View recent cluster events, often revealing errors related to scheduling, image pulls, volume mounts, probe failures, etc. Filter by namespace (`-n <namespace>`).
*   `kubectl cluster-info`: Check basic connectivity and component health.
*   `kubectl get componentstatus` (or `cs`): Check health of control plane components (scheduler, controller-manager, etcd).
*   `kubectl api-resources`: List available API resource types.
*   `kubectl explain <resource-type>`: Get documentation about resource fields (e.g., `kubectl explain pod.spec.containers`).

## Common Terraform Issues and Debugging Steps

*   **Authentication/Provider Errors:**
    *   **Symptom:** Errors mentioning credentials, access denied, authentication failed during `plan` or `apply`.
    *   **Check:** Verify cloud provider credentials (environment variables, shared files, IAM roles) are correctly configured and have sufficient permissions for the actions Terraform is trying to perform. Check provider region configuration. Run `aws sts get-caller-identity` or equivalent cloud CLI commands to verify active credentials.
*   **State Lock Errors:**
    *   **Symptom:** "Error acquiring the state lock".
    *   **Check:** Another Terraform process (maybe from a colleague or CI/CD pipeline) is holding the lock on the remote state file. Wait for it to finish or investigate the locking mechanism (e.g., DynamoDB table entry for S3 backend). If the lock is stale due to a crashed process, you might need to force-unlock it (`terraform force-unlock <LOCK_ID>`), but do this *only* if you are certain no other process is running.
*   **Resource Creation/Update Failures:**
    *   **Symptom:** `apply` fails with errors from the cloud provider API (e.g., "InvalidParameterValue", "LimitExceeded", "Conflict").
    *   **Check:** Read the error message carefully – it usually indicates the specific problem (invalid input value, resource quota exceeded, naming conflict, missing dependency). Review the relevant resource configuration in your `.tf` files. Check cloud provider documentation or console for details on the specific error.
*   **State Conflicts / Drift:**
    *   **Symptom:** `plan` shows unexpected changes (e.g., wants to destroy/recreate a resource you didn't intend to change).
    *   **Check:** The Terraform state file might be out of sync with the real infrastructure (drift). This can happen if changes were made manually outside Terraform.
    *   **Solution:**
        *   Run `terraform plan -refresh=true` (default) or `terraform refresh` to update the state file with the current reality. Review the new plan.
        *   If the manual change was intentional, consider using `terraform import` to bring the resource under Terraform management or adjust your Terraform code to match the manual change.
        *   If the manual change was unintentional, let Terraform revert it by running `apply`.
*   **Dependency Errors:**
    *   **Symptom:** Errors about missing resources or dependencies during `plan` or `apply`.
    *   **Check:** Ensure resource dependencies are correctly defined, either implicitly (by referencing attributes like `aws_vpc.main.id`) or explicitly (using `depends_on`). Verify that dependent resources are actually being created by your configuration.
*   **Provider/Module Version Issues:**
    *   **Symptom:** Errors during `init` or `plan` related to provider/module incompatibility or syntax changes.
    *   **Check:** Review provider/module documentation for breaking changes between versions. Ensure your `required_providers` and module `version` constraints are appropriate. Run `terraform init -upgrade` if necessary, but test carefully after upgrades.

**Terraform Debug Logging:**

*   To get more detailed output during Terraform runs, set the `TF_LOG` environment variable:
    *   `export TF_LOG=TRACE` (Most verbose)
    *   `export TF_LOG=DEBUG`
    *   `export TF_LOG=INFO`
    *   `export TF_LOG=WARN`
    *   `export TF_LOG=ERROR`
*   Run your `terraform plan` or `terraform apply` command again. The output will include detailed provider API calls and internal logic, which can be helpful for diagnosing complex issues. Remember to unset `TF_LOG` or set it back to `WARN`/`ERROR` afterwards.

Troubleshooting is a skill learned through experience. Start with `describe` and `logs` in Kubernetes, and carefully read error messages and `plan` output in Terraform. Systematically check potential causes, from basic syntax and configuration to resource state and external dependencies.
