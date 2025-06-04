# hello-world-devops


eksctl create cluster \
  --name hello-world-cluster \
  --region us-east-1 \
  --nodegroup-name linux-nodes \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 3 \
  --managed


eksctl delete cluster --name hello-world-cluster --region us-east-1

eksctl get cluster --region us-east-1

kubectl delete deployment hello-world-deployment

kubectl delete service hello-world-service

aws ecr describe-images --repository-name hello-world-devops --region us-east-1


# Build the image locally
docker build -t hello-world-devops .

# Tag the image with ECR repo + version
docker tag hello-world-devops:latest 248189939111.dkr.ecr.us-east-1.amazonaws.com/hello-world-devops:v1.1

# Authenticate with ECR
aws ecr get-login-password --region us-east-1 | \
docker login --username AWS --password-stdin 248189939111.dkr.ecr.us-east-1.amazonaws.com

# Push the image
docker push 248189939111.dkr.ecr.us-east-1.amazonaws.com/hello-world-devops:v1.1

aws ecr describe-images --repository-name hello-world-devops --region us-east-1


kubectl apply -f deployment.yaml

kubectl get pods
kubectl describe pod <pod-name>


kubectl rollout restart deployment hello-world-deployment

kubectl apply -f k8s/deployment.yaml

kubectl get pods
kubectl get svc hello-world-service


aws ecr delete-repository \
  --repository-name hello-world-devops \
  --region us-east-1 \
  --force
