# 🚀 Automate Docker Image Build and Deployment Using GitHub Actions

![GitHub Actions + Docker](https://img.shields.io/badge/GitHub%20Actions-Docker-blue?logo=githubactions&logoColor=white&style=for-the-badge)

This repository demonstrates how to **automate building, pushing, and deploying Docker images** using **GitHub Actions**. The CI/CD pipeline builds a Docker image with Docker-in-Docker (DIND), pushes it to Docker Hub, and runs the container automatically.

---

## 📘 **What You’ll Learn**
✅ Create a Dockerfile and GitHub Actions workflow.  
✅ Automate Docker image builds and pushes to Docker Hub.  
✅ Pull and run Docker containers automatically.  
✅ Securely manage credentials using GitHub Secrets.  

---

## 📝 **Project Structure**
```
📁 github-action-docker
├── 📄 Dockerfile
└── 📂 .github
    └── 📂 workflows
        └── 📄 docker.yml
```

---

## 🐳 **Dockerfile**
```Dockerfile
FROM alpine:latest
RUN apk --no-cache add docker
CMD ["sh"]
```
✅ *Pulls Alpine Linux and installs Docker inside the container.*

---

## 🔧 **GitHub Actions Workflow**
The `.github/workflows/docker.yml` workflow includes three jobs:
- **build:** Builds and pushes the Docker image to Docker Hub.
- **install-image:** Pulls the image after a successful build.
- **run-image:** Runs the pulled Docker image as a container.

📅 **Triggers:**
- Push to `main` branch  
- Pull requests targeting `main`  
- Version tags (`v*.*.*`)  
- Scheduled runs (daily at 4:35 AM UTC)  

```yaml
name: Docker

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  tags:
    - 'v*.*.*'
  schedule:
    - cron: '35 4 * * *'

jobs:
  build:
    runs-on: ubuntu-latest
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

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: dipakrasal2009/docker-inside-docker-dind:latest

  install-image:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Pull built image
        run: docker pull dipakrasal2009/docker-inside-docker-dind

  run-image:
    runs-on: ubuntu-latest
    needs: install-image
    steps:
      - name: Run Docker container
        run: docker run -dit --name OS1 dipakrasal2009/docker-inside-docker-dind
```

---

## 🔑 **GitHub Secrets Configuration**
To securely authenticate with Docker Hub, add the following secrets in your GitHub repository settings:
- `DOCKER_HUB_USERNAME`: Your Docker Hub username.  
- `DOCKER_PASSWORD`: Your Docker Hub access token.  

✅ *This prevents exposing sensitive information in the workflow.*

---

## 🚀 **How to Use**
1. **Clone this repo:**
   ```bash
   git clone https://github.com/your-username/github-action-docker.git
   cd github-action-docker
   ```
2. **Add your secrets** as mentioned above.
3. **Push your changes:**
   ```bash
   git add .
   git commit -m "Set up Docker GitHub Actions workflow"
   git push origin main
   ```
4. **Check the Actions tab** to see the workflow running.
5. **Verify the Docker image:**
   ```bash
   docker pull dipakrasal2009/docker-inside-docker-dind
   docker run -dit --name test-container dipakrasal2009/docker-inside-docker-dind
   docker ps  # Confirm the container is running
   ```

✅ **Trigger Explanation:**  
*When you push the workflow to the `main` branch, it will automatically trigger and start the further processes.*

---

## 📸 **Screenshots**
> 🖼️ *Add screenshots in the following sections:*  
> - GitHub repository creation  
> - Project folder structure  
> - Dockerfile and workflow file views  
> - GitHub Secrets configuration  
> - Running GitHub Actions workflow  
> - Terminal output with running container  

---

## 🎯 **Final Thoughts**
✅ Save time with automated builds and deployments.  
✅ Maintain consistent environments with scheduled runs.  
✅ Securely manage Docker Hub credentials.  

---

🔗 **Medium Blog:** [Read the full guide here](https://medium.com/@dipakrasal2009/automate-docker-image-build-and-deployment-using-github-actions-f21732d767c2)  
💬 Feel free to share feedback or raise issues! 🚀  

---

## 📝 **Author**
👤 Dipak Rasal  
🔗 [LinkedIn](https://www.linkedin.com/in/dipakrasal2009) | 🌐 [Medium](https://medium.com/@dipakrasal2009)  

---

⭐ *If you found this helpful, don’t forget to star the repo!* 🌟


