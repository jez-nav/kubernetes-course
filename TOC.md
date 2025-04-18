# Kubernetes and Terraform Course - Table of Contents

## Section 1: Course Structure (Parts & Chapters)

**Part 1: Foundations of Kubernetes and Containers**
*   Chapter 1: Introduction to Kubernetes
*   Chapter 2: Container Fundamentals
*   Chapter 3: Kubernetes Architecture

**Part 2: Core Kubernetes Concepts**
*   Chapter 4: Working with Pods
*   Chapter 5: Controllers and Workloads
*   Chapter 6: Services and Networking
*   Chapter 7: Storage in Kubernetes

**Part 3: Infrastructure as Code with Terraform**
*   Chapter 8: Introduction to Terraform
*   Chapter 9: Terraform Basics for Kubernetes
*   Chapter 10: Deploying Kubernetes Clusters with Terraform

**Part 4: Intermediate Kubernetes Skills**
*   Chapter 11: Configuration Management
*   Chapter 12: Scaling and Autoscaling
*   Chapter 13: Observability and Monitoring

**Part 5: Advanced Kubernetes and Terraform**
*   Chapter 14: Security Best Practices
*   Chapter 15: Custom Resources and Operators
*   Chapter 16: Advanced Terraform Techniques
*   Chapter 17: GitOps with Kubernetes

**Part 6: Real-World Kubernetes Applications**
*   Chapter 18: Deploying Microservices
*   Chapter 19: CI/CD for Kubernetes
*   Chapter 20: Managing Stateful Applications

**Part 7: Becoming a Kubernetes Expert**
*   Chapter 21: Performance Optimization
*   Chapter 22: Disaster Recovery and High Availability
*   Chapter 23: Contributing to Kubernetes Ecosystem
*   Chapter 24: Capstone Project

**Part 8: Appendices**
*   Appendix A: Kubernetes Ecosystem
*   Appendix B: Terraform Best Practices
*   Appendix C: Troubleshooting Guide
*   Appendix D: Further Reading

---

## Section 2: Chapter Content Overview

**Chapter 1: Introduction to Kubernetes**
*   What Kubernetes is and its benefits.
*   Comparison with other orchestrators (Docker Swarm, Nomad).
*   Core concepts: Containers, Pods, Clusters, Orchestration.
*   Guidance on setting up a local development environment (Minikube, kind, Docker Desktop).

**Chapter 2: Container Fundamentals**
*   Basics of containers, focusing on Docker.
*   Building and managing container images (Dockerfile).
*   Container registries (Docker Hub, private options).
*   Fundamental Docker networking and storage concepts.

**Chapter 3: Kubernetes Architecture**
*   Components of a Kubernetes cluster: Control Plane (API Server, etcd, Scheduler, Controller Manager) and Worker Nodes (kubelet, kube-proxy, container runtime).
*   Core workload resources: Pods, ReplicaSets, Deployments.
*   Kubernetes networking concepts: CNI, Services, DNS.
*   Storage concepts: Volumes, Persistent Volumes (PVs).

**Chapter 4: Working with Pods**
*   Creating and managing Pods directly (YAML, kubectl).
*   Multi-container Pod patterns (Sidecars).
*   Pod lifecycle phases and health checks (Liveness, Readiness, Startup probes).
*   Resource management: Requests and Limits.

**Chapter 5: Controllers and Workloads**
*   ReplicaSets for replication guarantees.
*   Deployments for managing stateless applications, rolling updates, and rollbacks.
*   DaemonSets for running Pods on specific nodes.
*   Jobs and CronJobs for batch and scheduled tasks.

**Chapter 6: Services and Networking**
*   Detailed look at Service types (ClusterIP, NodePort, LoadBalancer, ExternalName).
*   Ingress controllers and Ingress resources for managing external HTTP/S access.
*   Kubernetes DNS for internal service discovery.
*   NetworkPolicies for securing Pod communication.

**Chapter 7: Storage in Kubernetes**
*   Ephemeral and persistent Volume types.
*   PersistentVolumes (PVs) and PersistentVolumeClaims (PVCs) for abstracting storage.
*   StorageClasses for dynamic PV provisioning.
*   StatefulSets for managing stateful applications requiring stable storage and identity.

**Chapter 8: Introduction to Terraform**
*   Concept of Infrastructure as Code (IaC) and Terraform's role.
*   Comparison with other IaC tools (CloudFormation, Pulumi).
*   Installation and provider setup basics.
*   Writing a basic Terraform configuration (HCL).

**Chapter 9: Terraform Basics for Kubernetes**
*   Core Terraform workflow (init, validate, plan, apply, destroy).
*   Configuring cloud providers (AWS, GCP, Azure) and authentication.
*   Terraform language features: Variables, Outputs, Modules introduction.
*   State management concepts and the importance of remote backends.

**Chapter 10: Deploying Kubernetes Clusters with Terraform**
*   Using Terraform to provision managed Kubernetes clusters (EKS, GKE, AKS), focusing on modules.
*   Configuring cluster aspects (version, node pools, autoscaling).
*   Integrating Terraform with Kubernetes providers (briefly).
*   Managing cluster authentication (`kubeconfig`) via Terraform outputs.

**Chapter 11: Configuration Management**
*   Using ConfigMaps for non-sensitive application settings.
*   Using Secrets for sensitive data (passwords, API keys).
*   Methods for injecting configuration into Pods (environment variables, volumes, command-line args).
*   Brief discussion on managing configuration drift.

**Chapter 12: Scaling and Autoscaling**
*   Manual scaling techniques for Pods and Nodes.
*   Horizontal Pod Autoscaler (HPA) based on metrics (CPU/Memory).
*   Cluster Autoscaler (CA) for adjusting the number of cluster nodes.
*   Vertical Pod Autoscaler (VPA) for adjusting Pod resource requests/limits.

**Chapter 13: Observability and Monitoring**
*   Logging strategies in Kubernetes (stdout/stderr, sidecars, node agents).
*   Metrics collection using Prometheus and visualization with Grafana.
*   Introduction to distributed tracing concepts (Jaeger, Zipkin, OpenTelemetry).
*   Using Kubernetes Dashboard and `kubectl` for debugging.

**Chapter 14: Security Best Practices**
*   Role-Based Access Control (RBAC): Roles, ClusterRoles, Bindings, ServiceAccounts.
*   Pod Security Admission (PSA) and Pod Security Standards (Privileged, Baseline, Restricted).
*   Container image security (scanning, minimal bases, non-root).
*   Advanced network security with CNIs like Calico or Cilium.

**Chapter 15: Custom Resources and Operators**
*   Extending Kubernetes API with Custom Resource Definitions (CRDs).
*   The Operator pattern for automating application lifecycle management.
*   Benefits for complex stateful applications.
*   Tools for building Operators (Operator SDK, Kubebuilder).

**Chapter 16: Advanced Terraform Techniques**
*   Best practices for writing reusable Terraform modules.
*   Strategies for managing multi-environment setups (Workspaces vs. Directories).
*   Handling Terraform state securely in teams (remote backends, locking).
*   Integrating Terraform with CI/CD pipelines.

**Chapter 17: GitOps with Kubernetes**
*   GitOps principles: declarative, versioned, automated, reconciled.
*   Overview of GitOps tools (Argo CD, Flux).
*   Workflow for syncing Kubernetes manifests from Git.
*   Combining Terraform (infrastructure) and GitOps (applications).

**Chapter 18: Deploying Microservices**
*   Design considerations for microservices on Kubernetes.
*   Service discovery and communication patterns (Services, DNS, async).
*   Handling inter-service dependencies (startup, runtime).
*   Advanced deployment strategies (Blue-Green, Canary).

**Chapter 19: CI/CD for Kubernetes**
*   Typical CI/CD pipeline stages for Kubernetes applications.
*   Automating container builds and pushes.
*   Using Helm for packaging and deployment.
*   Integrating Terraform for infrastructure updates within pipelines.

**Chapter 20: Managing Stateful Applications**
*   Deploying databases (PostgreSQL, MySQL) using StatefulSets.
*   Backup and restore strategies (Volume Snapshots, App-level dumps, Velero).
*   Handling database schema migrations.
*   High availability patterns for stateful applications (replication, anti-affinity, PDBs, multi-AZ).

**Chapter 21: Performance Optimization**
*   Optimizing resource usage (CPU, Memory, Storage requests/limits).
*   Tuning Kubernetes scheduler and control plane components.
*   Optimizing container images and runtimes.
*   Importance of cluster performance monitoring.

**Chapter 22: Disaster Recovery and High Availability**
*   Designing HA cluster architectures (control plane, worker nodes, multi-AZ).
*   Cluster backup and restore using Velero.
*   Multi-region and multi-cluster architectural considerations.
*   Handling node, AZ, and cluster failures.

**Chapter 23: Contributing to Kubernetes Ecosystem**
*   Navigating Kubernetes source code.
*   Best practices for writing and sharing Helm charts.
*   Overview of ways to contribute to CNCF projects (docs, code, testing, community).
*   Introduction to Kubernetes Special Interest Groups (SIGs).

**Chapter 24: Capstone Project**
*   Outline of the final project requirements.
*   Integration of Terraform, Kubernetes deployment, CI/CD, monitoring, GitOps.
*   Example project ideas.
*   Definition of deliverables and evaluation criteria.

**Appendix A: Kubernetes Ecosystem**
*   Overview of key CNCF projects complementing Kubernetes.
*   Description of Kubernetes certifications (CKA, CKAD, CKS).
*   List of important community resources (Slack, GitHub, forums).

**Appendix B: Terraform Best Practices**
*   Summary of project structuring recommendations (modules, environments).
*   Recap of security practices (secrets management, least privilege).
*   Introduction to helpful tools (Terragrunt, tfsec, Infracost).

**Appendix C: Troubleshooting Guide**
*   Common Kubernetes issues (Pod status, networking) and diagnostic steps.
*   Common Terraform errors (auth, state, provider) and troubleshooting tips.
*   Key diagnostic commands.

**Appendix D: Further Reading**
*   List of recommended books on Kubernetes and Terraform.
*   Links to important online documentation and learning platforms.
*   Pointers to relevant online communities.

---

## Section 3: List of Labs

*   **Chapter 1 Lab:** Deploy a simple containerized app on Minikube
*   **Chapter 2 Lab:** Build and push a custom Docker image
*   **Chapter 3 Lab:** Explore a Kubernetes cluster with kubectl
*   **Chapter 4 Lab:** Deploy a pod with a sidecar logging container
*   **Chapter 5 Lab:** Deploy a scalable web app with rolling updates
*   **Chapter 6 Lab:** Expose an app with Ingress and secure it with network policies
*   **Chapter 7 Lab:** Deploy a database with persistent storage
*   **Chapter 8 Lab:** Provision a local Docker Container with Terraform
*   **Chapter 9 Lab:** Create a VPC and subnets for a Kubernetes cluster
*   **Chapter 10 Lab:** Deploy an EKS cluster with Terraform
*   **Chapter 11 Lab:** Deploy an app with ConfigMaps and Secrets
*   **Chapter 12 Lab:** Set up HPA for a web application
*   **Chapter 13 Lab:** Deploy a monitoring stack with Prometheus and Grafana
*   **Chapter 14 Lab:** Implement RBAC and secure a pod with policies
*   **Chapter 15 Lab:** Create a simple CRD and Custom Resource
*   **Chapter 16 Lab:** Refactor EKS Cluster to a Module
*   **Chapter 17 Lab:** Set up GitOps for a Kubernetes application with Argo CD
*   **Chapter 18 Lab:** Deploy a microservices-based e-commerce app
*   **Chapter 19 Lab:** Create a CI/CD pipeline for a Kubernetes app (GitHub Actions)
*   **Chapter 20 Lab:** Deploy a PostgreSQL cluster with backups
*   **Chapter 21 Lab:** Optimize a high-traffic app for low latency (Conceptual)
*   **Chapter 22 Lab:** Simulate and recover from a cluster failure (using Velero)
*   **Chapter 23 Lab:** Publish a Helm chart to a public repository (GitHub Pages)
*   **Chapter 24 Lab:** (Capstone Project - Defines the project, no specific lab steps)
