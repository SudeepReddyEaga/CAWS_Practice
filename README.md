# Sudeep Kumar Reddy - Webpage

A simple web application displaying a greeting message styled with a matte black background and dark red typography.

---

## 🚀 Running Locally

### Option 1: Direct in Browser
Simply double-click or open `index.html` in your web browser.

### Option 2: With Python & Flask
1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
2. Start the server:
   ```bash
   python app.py
   ```
3. Visit `http://localhost:5000` in your browser.

---

## 🐳 Docker

### 1. Build the Docker Image
```bash
docker build -t sudeep-webpage:latest .
```

### 2. Run the Docker Container
```bash
docker run -d -p 5000:5000 --name sudeep-webpage-app sudeep-webpage:latest
```
Access the application at `http://localhost:5000`.

---

## 🌐 Docker Hub Image

Your image is published on Docker Hub:
👉 **[sudeepkumarreddyeaga/caws-practice on Docker Hub](https://hub.docker.com/r/sudeepkumarreddyeaga/caws-practice)**

### Pull and Run from Anywhere:
```bash
docker run -d -p 5000:5000 --name sudeep-webpage-app sudeepkumarreddyeaga/caws-practice:latest
```

---

## ⚙️ AWS & Jenkins CI/CD Pipeline

This project includes a complete automated CI/CD pipeline triggered every **5 minutes** via Jenkins Poll SCM.

- **[Jenkinsfile](Jenkinsfile)**: Declarative pipeline with `pollSCM('H/5 * * * *')`, automated Docker build, container re-deployment, and health check.
- **[setup_aws_ec2.sh](setup_aws_ec2.sh)**: One-command setup script for Ubuntu EC2 instances (installs Git, Docker Engine, Java 17, and Jenkins).
- **[AWS_JENKINS_SETUP.md](AWS_JENKINS_SETUP.md)**: Full step-by-step guide with AWS Security Group configurations and Jenkins UI instructions.



---

## 📦 Pushing to Git

Initialize the git repository and push to your remote repository:

```bash
git init
git add .
git commit -m "Initial commit: greeting webpage with Docker and requirements setup"
git branch -M main
git remote add origin https://github.com/SudeepReddyEaga/CAWS_Practice.git
git push -u origin main
```
