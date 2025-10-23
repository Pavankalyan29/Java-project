pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '1087-9201-6419'
        REGION = 'ap-south-1'
        IMAGE_NAME = 'asciisum-app'
    }

    stages {
        stage('Setup AWS Credentials') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    bat '''
                        setx AWS_ACCESS_KEY_ID "%AWS_ACCESS_KEY_ID%"
                        setx AWS_SECRET_ACCESS_KEY "%AWS_SECRET_ACCESS_KEY%"
                        aws sts get-caller-identity
                    '''
                }
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Pavankalyan29/Java-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                bat '''
                    aws ecr get-login-password --region %REGION% | docker login --username AWS --password-stdin %AWS_ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com
                    docker tag %IMAGE_NAME%:latest %AWS_ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com/%IMAGE_NAME%:latest
                    docker push %AWS_ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com/%IMAGE_NAME%:latest
                '''
            }
        }

        stage('Terraform Deploy') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                    bat 'terraform apply -auto-approve'
                }
            }
        }
    }
}
