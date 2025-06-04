pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "hello-world-devops"
        ECR_URI = "248189939111.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/sagar-rathod-devops/hello-world-devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO:$IMAGE_TAG .'
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_URI
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                    docker tag $ECR_REPO:$IMAGE_TAG $ECR_URI:$IMAGE_TAG
                    docker push $ECR_URI:$IMAGE_TAG
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                    aws eks --region $AWS_REGION update-kubeconfig --name hello-world-cluster
                    kubectl set image deployment/hello-world hello-world=$ECR_URI:$IMAGE_TAG
                '''
            }
        }
    }
}
