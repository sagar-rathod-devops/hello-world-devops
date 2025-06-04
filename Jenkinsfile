pipeline {
    agent any

    environment {
        ECR_REPO = "248189939111.dkr.ecr.us-east-1.amazonaws.com/hello-world-devops:latest"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/your-username/hello-world-devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO .'
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin $ECR_REPO
                docker push $ECR_REPO
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/'
            }
        }
    }
}
