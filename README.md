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

## 📦 Pushing to Git

Initialize the git repository and push to your remote repository:

```bash
git init
git add .
git commit -m "Initial commit: greeting webpage with Docker and requirements setup"
git branch -M main
git remote add origin <YOUR_GITHUB_REPOSITORY_URL>
git push -u origin main
```
