pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '108792016419'
        REGION = 'ap-south-1'
        IMAGE_NAME = 'asciisum-app'
    }

    stages {
        // stage('Setup AWS Credentials') {
        //     steps {
        //         withCredentials([
        //             string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
        //             string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
        //         ]) {
        //             bat '''
        //                 setx AWS_ACCESS_KEY_ID "%AWS_ACCESS_KEY_ID%"
        //                 setx AWS_SECRET_ACCESS_KEY "%AWS_SECRET_ACCESS_KEY%"
        //                 aws sts get-caller-identity
        //             '''
        //         }
        //     }
        // }

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Pavankalyan29/Java-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                echo 'Pushing Docker image to AWS ECR...'
                withAWS(credentials: 'aws-creds', region: 'ap-south-1') {
                    bat '''
                    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 108792016419.dkr.ecr.ap-south-1.amazonaws.com
                    docker tag asciisum-app:latest 108792016419.dkr.ecr.ap-south-1.amazonaws.com/asciisum-app:latest
                    docker push 108792016419.dkr.ecr.ap-south-1.amazonaws.com/asciisum-app:latest
                    '''
                }
            }
        }
        stage('Terraform Deploy') {
            steps {
                echo 'Deploying infrastructure with Terraform...'
                dir('terraform') {
                    withAWS(credentials: 'aws-creds', region: '%REGION%') {
                        // Initialize Terraform
                        bat 'terraform init'

                        // Apply Terraform plan automatically
                        bat 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
    post {
        success {
            echo '✅ Build, push, and deploy successful!'
        }
        failure {
            echo '❌ Build failed. Check console output.'
        }
    }
}
