# payment-system

Infrastructure lab for experimenting with **Juspay Hyperswitch** and supporting payment stack services.

## What is included

- Local experimental stack via Docker Compose (PostgreSQL + Redis + pgAdmin)
- Terraform for **DigitalOcean** deployment
- Terraform for **Google Cloud Platform** deployment
- GitHub Actions `workflow_dispatch` pipelines for plan/apply/destroy on both clouds
- Generated defaults for missing values (randomized resource suffixes + generated DB password output)

---

## 1) Local experiment stack

```bash
docker compose up -d
```

This starts:

- PostgreSQL on `5432`
- Redis on `6379`
- pgAdmin on `5050`

> Hyperswitch itself is deployed on cloud instances through Terraform startup scripts that clone and run the official `juspay/hyperswitch` repository.

---

## 2) DigitalOcean deployment

Terraform path: `/home/runner/work/payment-system/payment-system/infrastructure/terraform/digitalocean`

### Required GitHub repository secrets

- `DIGITALOCEAN_TOKEN`
- `DO_SSH_PUBLIC_KEY`

### Optional GitHub repository variables

- `DO_PROJECT_NAME` (default: `hyperswitch-lab`)
- `DEPLOY_ENVIRONMENT` (default: `experiment`)
- `DO_REGION` (default: `sgp1`)
- `DO_DROPLET_SIZE` (default: `s-1vcpu-2gb`)

### Run workflow

- Go to **Actions** → **Deploy Hyperswitch to DigitalOcean**
- Click **Run workflow**
- Choose `plan`, `apply`, or `destroy`

---

## 3) GCP deployment

Terraform path: `/home/runner/work/payment-system/payment-system/infrastructure/terraform/gcp`

### Required GitHub repository secrets

- `GCP_CREDENTIALS_JSON` (service account JSON with compute permissions)
- `GCP_SSH_PUBLIC_KEY`

### Required GitHub repository variables

- `GCP_PROJECT_ID`

### Optional GitHub repository variables

- `GCP_REGION` (default: `asia-southeast1`)
- `GCP_ZONE` (default: `asia-southeast1-b`)
- `GCP_RESOURCE_PREFIX` (default: `hyperswitch-lab`)
- `GCP_MACHINE_TYPE` (default: `e2-medium`)
- `GCP_SSH_USER` (default: `ubuntu`)

### Run workflow

- Go to **Actions** → **Deploy Hyperswitch to GCP**
- Click **Run workflow**
- Choose `plan`, `apply`, or `destroy`

---

## 4) Notes on generated values

Both Terraform stacks generate:

- Random 4-char suffix for resource names
- Random database password (`generated_db_password` Terraform output, marked sensitive)

These generated values are provided for experimentation and extension when you add managed DB/services later.
