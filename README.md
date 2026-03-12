# Multi-Tier WordPress & MySQL Deployment on Kubernetes

## 📌 Project Overview

This project demonstrates a production-ready, multi-tier deployment of a WordPress application using Kubernetes. As a DevOps engineer, the goal was to architect a system that ensures data persistence, secure configuration management, and role-based access control (RBAC).

### 🎯 Objectives

* 
**Orchestration:** Bootstrap a cluster using `kubeadm` and manage resources with `kubectl`.


* 
**High Availability:** Deploy WordPress and MySQL using Kubernetes Deployments.


* 
**Data Persistence:** Implement an NFS-backed Persistent Volume system for database stability.


* 
**Security:** Manage sensitive data via Kubernetes Secrets and non-sensitive data via ConfigMaps.


* 
**Governance:** Configure the Kubernetes Dashboard with Admin and Read-Only user roles.



---

## 🏗 Project Architecture

| Component | Technology | Role |
| --- | --- | --- |
| **Orchestrator** | Kubernetes (v1.29+) | Container orchestration and management.

 |
| **Frontend** | WordPress (latest) | Web application tier.

 |
| **Backend** | MySQL 5.7 | Relational database tier.

 |
| **Storage** | NFS Server | Persistent storage backend for DB data.

 |
| **Networking** | Flannel (CNI) | Internal pod networking and service discovery. |

---

## 📂 Project Structure

```text
.
├── dashboard/
[cite_start]│   ├── dashboard-admin.yaml      # Admin ServiceAccount & ClusterRoleBinding [cite: 31]
[cite_start]│   └── dashboard-readonly.yaml   # View-only permissions for auditing [cite: 14]
├── database/
[cite_start]│   ├── mysql-deployment.yaml     # MySQL Deployment with strategy: Recreate [cite: 29]
[cite_start]│   ├── mysql-secret.yaml         # Base64 encoded DB credentials [cite: 35]
[cite_start]│   └── mysql-service.yaml        # Internal ClusterIP service [cite: 30]
├── storage/
[cite_start]│   ├── pv.yaml                   # NFS-backed Persistent Volume [cite: 34]
[cite_start]│   └── pvc.yaml                  # Claim for storage resources [cite: 33]
├── wordpress/
[cite_start]│   ├── wordpress-configmap.yaml  # DB Host and Name configurations [cite: 36]
[cite_start]│   ├── wordpress-deployment.yaml # WordPress application deployment [cite: 29]
[cite_start]│   └── wordpress-service.yaml    # External NodePort service (Port 30007) [cite: 30]
[cite_start]├── namespace.yaml                # Dedicated namespace 'cep-project1' [cite: 6]
[cite_start]└── script-exec.sh                # Automation script for full deployment [cite: 28]

```

---

## 🚀 Deployment Steps

### 1. Bootstrap the Environment

For detailed steps on installing the Kubernetes Dashboard and initial setup, refer to the [OneUptime Kubernetes Dashboard Guide](https://oneuptime.com/blog/post/2026-01-15-install-kubernetes-dashboard-ubuntu/view#creating-an-admin-user-and-rbac-configuration).

Apply the namespace and RBAC configurations for the dashboard:

```bash
kubectl apply -f namespace.yaml
kubectl apply -f dashboard/

```

### 2. Configure Storage

Ensure your NFS server is running at `172.23.8.94` and exports `/nfs-share`. Then apply the storage manifests:

```bash
kubectl apply -f storage/pv.yaml
kubectl apply -f storage/pvc.yaml

```

### 3. Deploy the Multi-Tier App

Use the provided execution script to deploy the database and frontend in the correct order:

```bash
chmod +x script-exec.sh
./script-exec.sh

```

---

## 🔍 Verification & Access

### Service Discovery

Verify that all services are correctly assigned ClusterIPs and NodePorts:

```bash
kubectl get svc -n cep-project1

```

### Accessing the Application

* **WordPress Web UI:** `http://172.23.8.94:30007`
* **Kubernetes Dashboard:** `https://172.23.8.94:30443`

### Generate Admin Token

To log in to the dashboard, generate a bearer token for the `admin-user`:

```bash
kubectl -n kubernetes-dashboard create token admin-user

```

---

## 🛠 Troubleshooting

* **Pending Pods:** Check if the node is tainted or if the CNI (Flannel) is missing.
* 
**DB Connection Error:** Ensure the `MYSQL_DATABASE` variable in `mysql-deployment.yaml` matches the `WORDPRESS_DB_NAME` in the ConfigMap.
* 
**NFS Mount Failure:** Verify that `nfs-common` is installed on all worker nodes.
---
## SCREENSHOTS

https://github.com/user-attachments/assets/04c823fa-561b-4c76-8f5c-bd04d2dc7724


<img width="1353" height="435" alt="Image" src="https://github.com/user-attachments/assets/2b7c6978-ca71-4db0-a60a-f37529d9a9b4" />

<img width="1353" height="435" alt="Image" src="https://github.com/user-attachments/assets/b893dcb9-a7b3-4148-b82d-fc807ed9d6d7" />

<img width="1417" height="97" alt="Image" src="https://github.com/user-attachments/assets/0e98caa0-8de1-4d6f-b565-6cc26726259e" />

<img width="1417" height="97" alt="Image" src="https://github.com/user-attachments/assets/6fe74596-893a-4e96-9eaa-c1bc3b352cad" />

<img width="1417" height="97" alt="Image" src="https://github.com/user-attachments/assets/b07b6674-5ff6-48d2-96e6-6cb6cde338e6" />

<img width="1092" height="888" alt="Image" src="https://github.com/user-attachments/assets/d24b0bb9-a008-4b2a-aa5b-9a52bae32b24" />

<img width="1092" height="888" alt="Image" src="https://github.com/user-attachments/assets/88af7347-52c7-4238-80ba-4a72e8b67859" />

<img width="1765" height="1009" alt="Image" src="https://github.com/user-attachments/assets/c369836d-5c3e-4672-a220-5e7b6216f004" />



