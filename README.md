# NGINX DevOps demo

A non-root NGINX container returns the current date/time, its IP address, and its hostname. This is the local application stage of a future GitHub Actions security scanning, build, test, and AWS deployment project.

## Files

- `nginx/default.conf`: response and health endpoint.
- `Dockerfile`: packages the configuration using a digest-pinned NGINX base image.
- `.dockerignore`: excludes unrelated and sensitive files from the build context.
- `.gitignore`: excludes local credentials from Git.

## Build and validate (PowerShell)

Start Docker Desktop with Linux containers, then run:

```powershell
Set-Location I:\github_action\nginx-devops-demo
docker build -t nginx-devops-demo:local .
docker run --rm nginx-devops-demo:local nginx -t
```

## Start

```powershell
docker run -d --name nginx-demo --hostname nginx-demo -p 127.0.0.1:8080:8080 nginx-devops-demo:local
```

Open http://localhost:8080. The port is bound to your local computer only.

If the container already exists, use `docker start nginx-demo`. This starts the existing container; it does not apply a rebuilt image. To apply a rebuilt image, stop and remove the existing demo container, then repeat the run command.

## Check

```powershell
curl.exe --fail http://localhost:8080/
curl.exe --fail http://localhost:8080/health
docker ps --filter name=nginx-demo
docker logs nginx-demo
docker exec nginx-demo id
```

The root response contains `Date`, `IP`, and `Hostname`. Refresh to see a new request-time date. The date uses the container's timezone; the IP and hostname describe the container, not the Windows computer or a future EC2 public address. The health response is `healthy`. The process UID is non-zero.

## Stop and restart

```powershell
docker stop nginx-demo
docker start nginx-demo
```

## Remove the demo container

```powershell
docker stop nginx-demo
docker rm nginx-demo
```

## Next stages

1. Initialize Git, commit these files, and push to your GitHub repository.
2. Add Dockerfile linting, secret/configuration scanning, image scanning, and HTTP smoke tests to GitHub Actions.
3. Configure AWS ECR, EC2, Systems Manager, and IAM with GitHub OIDC.
4. Publish and deploy the validated image, check the deployment, and practice rollback.

The local setup does not yet include security scans, GitHub workflows, or AWS resources. Keep credentials out of this directory.
