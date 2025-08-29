pipeline {
    agent any
    tools {
        maven 'maven'
    }
    environment {
        HARBOR_URL = '59.11.2.207:59007'
        HARBOR_PROJECT = 'mvn-test2'
        IMAGE_NAME = "${HARBOR_URL}/${HARBOR_PROJECT}/cicd-web-project"
        DOCKER_CREDENTIALS_ID = 'harbor-credentials'
        APP_PORT = '59009'  
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/kde0707/cicd-web-project.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry("http://${HARBOR_URL}", "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry("http://${HARBOR_URL}", "${DOCKER_CREDENTIALS_ID}") {
                        sh """
                        echo "Deploying on local server..."
                        docker pull ${IMAGE_NAME}:${env.BUILD_NUMBER}
                        docker stop cicd-web || true
                        docker rm cicd-web || true
                        docker run -d --name cicd-web -p 59006:8080 ${IMAGE_NAME}:${env.BUILD_NUMBER}
                        """
                    }
                }
            }
        }
    }
}
