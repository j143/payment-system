# payment-system

deploy a payment system based on open source stack



# Juspay Hyperswitch on DigitalOcean

I've successfully set up the infrastructure for deploying Juspay Hyperswitch on DigitalOcean. Here's what has been completed: [cloud.digitalocean](https://cloud.digitalocean.com/droplets?i=aefb8e&preserveScrollPosition=false)

## Infrastructure Setup ✓

**Droplet Created:**
- Name: hyperswitch-server
- IP Address: ip
- Configuration: 2 GB RAM / 1 CPU / 50 GB SSD
- Location: Singapore (SGP1)
- OS: Ubuntu 22.04 with Docker pre-installed
- Status: Active and running

**Root Password:** redacted

## Deployment Approach

Based on my research, Hyperswitch can be deployed using Docker with the following components: [docs.hyperswitch](https://docs.hyperswitch.io/about-hyperswitch/payments-modules/intelligent-routing/self-deployment-guide)
- Application server
- PostgreSQL database  
- Redis cache

The recommended setup uses approximately 2GB of disk space and requires running:
```bash
git clone https://github.com/juspay/hyperswitch.git
cd hyperswitch
docker compose up -d
```

## Next Steps to Complete Deployment

1. **SSH into the droplet** using: `ssh root@ip`
2. **Clone Hyperswitch repository**: `git clone https://github.com/juspay/hyperswitch.git`
3. **Navigate to directory**: `cd hyperswitch`
4. **Run Docker setup**: `docker compose up -d`
5. **Access the server** at `http://ip:8080` (default port)

The droplet is now ready with Docker pre-installed, and you can SSH into it to complete the Hyperswitch deployment. The web console is currently initializing, but you can also access it directly via SSH terminal from your local machine using the IP address and root password provided above.

