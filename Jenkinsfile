pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_REGION            = 'ap-south-1'
        ECR_REPO_NAME         = 'asciisum-app'
        ACCOUNT_ID            = '123456789012'  // replace with your AWS account ID
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Pavankalyan29/Java-project.git'
            }
        }

        stage('Compile Java Code') {
            steps {
                echo 'Compiling Java Program...'
                bat 'javac AASCIISum.java'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t %ECR_REPO_NAME% .'
            }
        }

        stage('Authenticate to ECR') {
            steps {
                echo 'Logging into AWS ECR...'
                bat '''
                aws ecr get-login-password --region %AWS_REGION% | docker login --username AWS --password-stdin %ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com
                '''
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                echo 'Pushing Docker image to ECR...'
                bat '''
                docker tag %ECR_REPO_NAME% %ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com/%ECR_REPO_NAME%:latest
                docker push %ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com/%ECR_REPO_NAME%:latest
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    bat 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    bat 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}
