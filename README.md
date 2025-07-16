# EGLE_WEB

---

## Overview

This Repo is a great test of mental and physical strength which I have failed repeatedly except for that one time when I was 10 that I hosted my own website which was just a clean rip-off of the charts.

---

## Deployment

In what may be a golden age for easy deployment, can I deploy a website using a git repo and a Hetnzer server (or AWS if I can't get it going on Hetzner)

---

## Local Testing

To test a locally dockerised version of the site use this command:

```sh
docker run --rm -it \
    -p 8080:80 \
    -v "$(pwd)/site":/usr/share/nginx/html:ro \
    nginx:alpine
```

and you should see a site on [http://localhost:8080](http://localhost:8080)

---

## Deploying to Hetzner with Terraform

To deploy your site to Hetzner using Terraform, follow these steps:

1. **Initialize Terraform**  
    Run `terraform init` in your project directory to initialize the configuration.

2. **Preview the Deployment**  
    Use `terraform plan` to see what changes will be made.

3. **Apply the Configuration**  
    Deploy resources with `terraform apply`. Confirm the action when prompted.

4. **Destroy Resources**  
    When you want to tear down the infrastructure, run `terraform destroy`.

Make sure your `terraform.tf` files are configured for Hetzner and that you have the necessary API tokens set in your environment.

---

## Simplified Deployment with `deploy.sh`

The deployment process has been streamlined. Since the server is already provisioned, you no longer need to manage infrastructure with Terraform. To deploy updates:

1. **Commit and push your changes**  
   First, make sure your local changes are committed and pushed to GitHub:
   ```sh
   git add .
   git commit -m "Update website content"
   git push origin main
   ```

2. **Deploy to server**  
   Use the provided `deploy.sh` script to pull the latest changes and deploy:
   ```sh
   ./deploy.sh
   ```

This script connects to your server, pulls the latest code from your GitHub repository, and syncs the files to the web directory. Ensure you have the necessary SSH access and permissions configured.