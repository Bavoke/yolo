# Yolo E-Commerce App - DevOps Stage 1

This project deploys a full-stack application using Ansible roles for each service.

## Requirements

- Vagrant (on Windows)
- VirtualBox
- WSL or Git Bash (for Ansible)

## Setup Instructions

1. Make sure Vagrant and VirtualBox are installed.
2. Run:
   ```powershell
   vagrant up

   The app will be available at: http://localhost:8080

   
✅ Save and exit.

---

## 🔹 Step 9: Create `explanation.md`

```bash
nano explanation.md


# Ansible Playbook Explanation

This Ansible playbook uses modular roles to deploy a full-stack e-commerce dashboard.

## Roles

1. **setup-mongodb**: Sets up MongoDB container with persistent volume and custom network.
2. **backend-deployment**: Deploys Node.js backend connected to MongoDB.
3. **frontend-deployment**: Deploys React frontend connected to backend.

Each role defines:
- Variables in `vars/main.yml`
- Tasks in `tasks/main.yml`

## Tags

Each role is tagged:
- `mongodb`, `backend`, `frontend`

This allows selective execution during testing or troubleshooting.

## Execution Flow

1. The playbook runs on a Vagrant-provisioned Ubuntu VM.
2. It pulls images and starts containers in order: MongoDB → Backend → Frontend.
3. All containers run on a shared network to allow communication.