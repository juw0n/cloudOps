## AWS Three-Tier Web Architecture

This project walks through deploying a scalable, secure, and highly available three-tier web application on AWS

Architecture Overview

The setup follows a classic three-tier model:
1. Web Tier – React.js + NGINX servers in a public subnet behind an internet-facing ALB.
2. App Tier – Node.js backend servers in private subnets behind an internal ALB.
3. Database Tier – Amazon Aurora (MySQL-compatible) in private subnets, Multi-AZ.

### Part 0: Setup
Create a project repo and give is a suitable name and navigate into the repo from a code editor.
1. Download the code from aws worskshop Repo by cloning the repository:
   ```bash
   git clone https://github.com/aws-samples/aws-three-tier-web-architecture-workshop.git
   ```

Create a terrform skafold files for the project
```bash
touch main.tf variables.tf outputs.tf provider.tf
```
Inside the main.tf file
1. Create an S3 bucket resource for storing code
2. Create an IAM role resource for EC2 with SSM and S3 access
3. Attach SSM and S3 access policies to the IAM role

### Part 1: Networking and Security
Create an isolated network with the following components:
    * VPC
    * Subnets
    * Route Tables
    * Internet Gateway
    * NAT gateway
    * Security Groups
