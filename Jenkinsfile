// pipeline {
//     agent any

//     stages {
//         stage('Checkout Code') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Pavankalyan29/Java-project.git'
//             }
//         }

//         stage('Compile Java Code') {
//             steps {
//                 echo 'Compiling Java Program...'
//                 bat 'javac AASCIISum.java'
//             }
//         }

//         stage('Run Java Program') {
//             steps {
//                 echo 'Running Java Program...'
//                 // For now, we’ll just give it a test input. You can modify this later.
//                 bat 'echo HelloWorld | java AASCIISum'
//             }
//         }

//         stage('Archive Artifacts') {
//             steps {
//                 archiveArtifacts artifacts: '*.class', fingerprint: true
//             }
//         }
//     }

//     post {
//         success {
//             echo '✅ Build successful!'
//         }
//         failure {
//             echo '❌ Build failed. Check console output for details.'
//         }
//     }
// }



pipeline {
    agent any

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

        stage('Run Java Program') {
            steps {
                echo 'Running Java Program...'
                bat 'echo HelloWorld | java AASCIISum'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t asciisum-app .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                // Pass input automatically using echo
                bat 'echo HelloWorld | docker run -i asciisum-app'
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
            echo '✅ Build successful!'
        }
        failure {
            
            echo '❌ Build failed. Check console output for details.'
        }
    }
}
