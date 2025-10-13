pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Pull your Java project from GitHub
                git branch: 'main', url: 'https://github.com/Pavankalyan29/Java-project.git'
            }
        }

        stage('Compile Java Code') {
            steps {
                echo 'Compiling Java Program...'
                sh 'javac AASCIISum.java'
            }
        }

        stage('Run Java Program') {
            steps {
                echo 'Running Java Program...'
                // Input can be passed from a file or echo command
                // Example: using echo to simulate user input
                sh 'echo "Hello" | java AASCIISum'
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo 'Archiving compiled files...'
                archiveArtifacts artifacts: '**/*.class', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Build and execution completed successfully!'
        }
        failure {
            echo '❌ Build failed. Check console output for details.'
        }
    }
}
