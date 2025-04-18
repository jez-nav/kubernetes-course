# Comprehensive Kubernetes and Terraform Course

## Overview

Welcome! This repository contains the materials for a comprehensive course designed to take learners from foundational concepts to expert-level practitioners in Kubernetes and Terraform. The course targets individuals with some development background (basic coding, CLI usage) aiming to master the deployment, management, and scaling of cloud-native applications and infrastructure.

Through a structured progression of theory, hands-on labs, and a final capstone project, learners will gain the skills necessary for roles like DevOps Engineer, SRE, or Cloud Architect in modern cloud-native environments.

## Course Structure

The course is divided into eight parts:

*   **Part 1: Foundations of Kubernetes and Containers**
    *   Introduces Kubernetes, its core concepts (Pods, Clusters), and benefits. Covers container fundamentals using Docker, including building images and basic networking/storage. Explores the Kubernetes architecture (Control Plane, Nodes).
*   **Part 2: Core Kubernetes Concepts**
    *   Dives deeper into managing Pods (lifecycle, health checks, resources), workload controllers (Deployments, StatefulSets, DaemonSets, Jobs), networking (Services, Ingress, DNS, NetworkPolicies), and persistent storage (Volumes, PVs, PVCs, StorageClasses).
*   **Part 3: Infrastructure as Code with Terraform**
    *   Introduces Terraform for managing infrastructure declaratively. Covers the core workflow, managing cloud providers (AWS focus in labs), variables, outputs, modules, and state management. Culminates in deploying a managed Kubernetes cluster (EKS) using Terraform.
*   **Part 4: Intermediate Kubernetes Skills**
    *   Focuses on managing application configuration (ConfigMaps, Secrets), scaling applications and clusters (HPA, Cluster Autoscaler, VPA), and establishing observability (logging, metrics with Prometheus/Grafana, tracing concepts).
*   **Part 5: Advanced Kubernetes and Terraform**
    *   Covers crucial security best practices (RBAC, Pod Security Admission), extending Kubernetes with CRDs and Operators, advanced Terraform techniques (modules, multi-environment setups, CI/CD integration), and implementing GitOps workflows (Argo CD/Flux).
*   **Part 6: Real-World Kubernetes Applications**
    *   Applies learned concepts to practical scenarios: deploying microservices, building CI/CD pipelines for Kubernetes (including Helm), and managing stateful applications (databases, backups, migrations, HA).
*   **Part 7: Becoming a Kubernetes Expert**
    *   Explores performance optimization techniques, disaster recovery strategies (including Velero), multi-cluster architectures, and contributing back to the Kubernetes/CNCF ecosystem. Defines the final Capstone Project.
*   **Part 8: Appendices**
    *   Provides supplementary material on the broader Kubernetes ecosystem, Terraform best practices summaries, a troubleshooting guide, and resources for further reading.

## Learning Approach

*   **Declarative:** Emphasizes defining desired states using YAML (Kubernetes) and HCL (Terraform).
*   **Hands-On:** Each chapter (where applicable) includes a practical lab exercise to reinforce concepts.
*   **Progressive:** Builds knowledge from fundamental concepts to advanced, real-world applications.
*   **Integrated:** Teaches Kubernetes application management alongside Terraform infrastructure management.

## Getting Started

Navigate through the `Part X/` directories to access the course content for each section. The `TOC.md` file provides a detailed Table of Contents.

Enjoy your learning journey into Kubernetes and Terraform!
