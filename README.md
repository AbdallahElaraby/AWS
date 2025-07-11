# Apache Web Stress Tester on EC2

This project sets up a simple, scalable Apache web application on AWS EC2 instances that allows users to trigger a CPU stress test from a web interface.

## 🚀 Features

- Apache + PHP installed automatically via EC2 User Data
- Web UI with a "Stress EC2" button (runs `stress` for 300 seconds)
- Deployed in an Auto Scaling Group in **private subnets**
- Uses **Application Load Balancer** for public access
- Uses **CloudWatch + SNS** for alerting on CPU metrics
- All internet-bound traffic from private subnets goes through a **NAT Gateway**

---

## 🖼️ Architecture Overview

![Architecture Diagram] (architecture.png)

### Key Components:

- **1 VPC** (custom)
- **4 Subnets**:
  - 2 Public (for ALB & NAT Gateway)
  - 2 Private (for EC2 instances)
- **Application Load Balancer (ALB)** in public subnets
- **Auto Scaling Group (ASG)** in private subnets hosting Apache EC2 instances
- **NAT Gateway** in public subnet for private instances to access internet
- **CloudWatch** monitors CPU metrics
- **SNS** sends alerts when thresholds are exceeded

---

## 📁 Project Structure

```bash
.
├── user-data-script.sh      # EC2 User Data script
├── index.php                # PHP Web UI for CPU stress
├── README.md
└── architecture.png         # System architecture diagram
```

---

## 🛠️ Technologies Used

- Amazon EC2 (Amazon Linux 2)
- Apache HTTP Server
- PHP
- `stress` (from EPEL)
- ALB, ASG, NAT Gateway, VPC
- CloudWatch & SNS for alerting

---

## 🧪 How to Use

1. Launch EC2 instance(s) in **private subnet** using a **launch template** with the provided user data
2. Attach the EC2s to an Auto Scaling Group (ASG)
3. Expose via an **Application Load Balancer** in public subnets
4. Make sure your private subnet has a route to the internet via **NAT Gateway**
5. Open port 80 in the security group
6. Access the app via your ALB DNS name

---

## 📌 Notes

- Apache serves a PHP page with a button that runs:  
  ```bash
  stress --cpu 2 --timeout 300
  ```
- Useful for learning about EC2 automation, stress testing, and monitoring
- Not secured for production use
