# Automate Docker Image Build and Push Using GitHub Actions 🐳

Hey everyone! 👋  
This README will guide you through automating the process of building and pushing Docker images using **GitHub Actions**. We'll set up a **CI/CD pipeline** that builds a Docker image and pushes it to **Docker Hub**.

> 🚀 *This guide is designed to be simple and beginner-friendly!*

---

## 📘 What You'll Learn
✅ Setting up a GitHub repository with a Dockerfile  
✅ Creating a GitHub Actions workflow for automated Docker builds  
✅ Pushing Docker images to Docker Hub  

---

## 📝 Step 1: Create a GitHub Repository
1. **Create a repository:**
   - Go to GitHub and create a new repository (e.g., `github-action-docker`).
   - Add a `README.md` file to describe your project.

2. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/github-action-docker.git
   cd github-action-docker
   ```
   ✅ This allows you to work on the project files from your local machine.

---

## 🐳 Step 2: Write the Dockerfile
Create a file named `Dockerfile` inside the cloned repository with the following content:

```dockerfile
FROM redhat/ubi8

RUN yum install python3 -y
RUN pip3 install flask

WORKDIR /code
COPY app.py app.py

ENTRYPOINT ["python3", "app.py"]
```

### 📝 Explanation:
- **FROM redhat/ubi8:** Uses Red Hat Universal Base Image 8 as the base image.
- **RUN yum install python3 -y:** Installs Python 3.
- **RUN pip3 install flask:** Installs the Flask web framework.
- **WORKDIR /code:** Sets the working directory inside the container.
- **COPY app.py app.py:** Copies `app.py` to the container.
- **ENTRYPOINT ["python3", "app.py"]:** Runs the Flask application.

✅ This Dockerfile creates a minimal environment to run a Flask app inside a Docker container.

---

## 🔧 Step 3: Set Up the GitHub Actions Workflow
GitHub Actions automates tasks like building and pushing Docker images.

1. **Create the workflow directory:**
   ```bash
   mkdir -p .github/workflows
   ```
   ✅ GitHub looks for workflows in this specific directory.

2. **Create the workflow file:**  
Create a file named `.github/workflows/docker.yml` and add the following code:

```yaml
name: Docker

on:
  schedule:
    - cron: '35 4 * * *'  # Runs daily at 4:35 AM UTC
  push:
    branches: ["main"]
    tags: ['v*.*.*']
  pull_request:
    branches: ["main"]

env:
  REGISTRY: docker.io
  IMAGE_NAME: dipakrasal2009/github-action-docker

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
      id-token: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log into Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_HUB_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Extract Docker metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ env.IMAGE_NAME }}:latest
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
```

### 🚀 **When does it run?**
✅ Daily at **4:35 AM UTC** (scheduled build)  
✅ On pushes to the **main** branch and version tags (e.g., `v1.0.0`)  
✅ On **pull requests** targeting `main`  

### ⚙️ **What does it do?**
✅ Checks out code  
✅ Sets up Docker Buildx  
✅ Logs into Docker Hub (securely using GitHub secrets)  
✅ Extracts metadata (tags and labels the Docker image)  
✅ Builds & pushes the Docker image to Docker Hub:
```
dipakrasal2009/github-action-docker:latest
```

✅ **Why use it?**
- Fully automated and secure 🔒  
- Faster builds with caching ⚡  
- Consistent and up-to-date Docker images 🔄  

---

## 🔑 Step 4: Configure GitHub Secrets
Securely log into Docker Hub without exposing credentials:

1. Navigate to your repo: **Settings → Secrets and variables → Actions**
2. Add the following secrets:
   - `DOCKER_HUB_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub access token

✅ **Secrets keep sensitive data hidden from workflow logs.**

---

## 🚀 Step 5: Push Code and Trigger the Workflow
Push your code to initiate the CI/CD pipeline:

```bash
git add .
git commit -m "Add Dockerfile and GitHub Actions workflow"
git push origin main
```

✅ Check the **Actions** tab on GitHub to monitor the pipeline in real-time.

---

