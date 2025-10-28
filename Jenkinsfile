pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '108792016419'
        REGION = 'ap-south-1'
        IMAGE_NAME = 'asciisum-app'
        ECR_URI = '108792016419.dkr.ecr.ap-south-1.amazonaws.com/asciisum-app:latest'
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
                bat 'javac asciiSum.java'
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
                withAWS(credentials: 'aws-creds', region: "${REGION}") {
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
                dir('terraform') {
                    withAWS(credentials: 'aws-creds', region: "${REGION}") {
                        echo 'Initializing Terraform...'
                        bat 'terraform init'
                        bat 'terraform validate'
                        bat 'terraform plan'
                        bat 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Kubernetes Deploy') {
            steps {
                echo 'Deploying to Kubernetes...'
                bat '''
                aws ecr get-login-password --region ap-south-1 | kubectl create secret docker-registry ecr-secret --docker-server=108792016419.dkr.ecr.ap-south-1.amazonaws.com --docker-username=AWS --docker-password-stdin || echo "Secret exists"
                kubectl apply -f k8s/deployment.yaml
                kubectl apply -f k8s/service.yaml
                kubectl get pods
                '''
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: '*.class', fingerprint: true
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
