# Stage Two – Terraform + Ansible Automation

In this stage, I've extended my earlier Vagrant + Ansible automation to use **Terraform** for infrastructure provisioning and **Ansible** for application configuration.

## What's Included

- ✅ Terraform scripts to spin up MongoDB, backend, and frontend containers
- ✅ Ansible playbook reused from Stage 1
- ✅ Data persistence via named volume (`mongo_data`)
- ✅ Container networking (`app-network`)
- ✅ End-to-end connectivity between services

## Requirements

- Terraform CLI
- Docker installed locally
- Ansible (optional, if you're running Ansible manually)
- Internet access for image pulls

## How to Use

1. Clone this repo:
   ```bash
   git clone -b Stage_two https://github.com/Bavoke/yolo.git 
   cd yolo


1. Initialize Terraform:
bash

 terraform init
 
 
 3.Apply:

 bash 
 terraform apply


4. Open browser:

 http://localhost:3000



5.  Try adding products via form – they should persist across restarts


**Deliverables**
- ✅ Infrastructure created using Terraform
- ✅ Services configured using Ansible
- ✅ Reproducible environment
- ✅ End-to-end product persistence



---

## 📝 Example `explanation.md`

```markdown
# Explanation Document – Stage Two

## Execution Flow

1. Terraform creates Docker containers using the Docker provider
2. Containers are attached to a shared network (`app-network`)
3. Ansible runs against each container to configure and deploy the app
4. Product data persists in MongoDB via a named volume

## Role Breakdown

- `setup-docker`: Ensures Docker is available
- `setup-mongodb`: Pulls and starts MongoDB container
- `backend-deployment`: Deploys Node.js API and connects to DB
- `frontend-deployment`: Deploys React frontend and exposes port 3000

## Module Usage

- `docker_container`: Used to define and run each service
- `docker_network`: Ensures containers can communicate
- `docker_volume`: Ensures MongoDB saves data
- `ansible` module: Reused for configuration and deployment

## Tagging Strategy

Each role has its own tag (`docker`, `mongodb`, `backend`, `frontend`) allowing selective execution.

## Final Notes

This automation allows anyone to run:
```bash
terraform apply


And get a fully working, containerized e-commerce platform.