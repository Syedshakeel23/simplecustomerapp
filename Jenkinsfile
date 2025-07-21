pipeline {
    agent any

    environment {
        IMAGE_NAME = "syed411/simplecustomer"
        WAR_URL = "http://34.203.202.65:8081/repository/Simplecustomerapp/com/javatpoint/SimpleCustomerApp/1.0.0-SNAPSHOT/SimpleCustomerApp-1.0.0-20250721.185847-1.war"
    }

    stages {
        stage('Create Build Context') {
            steps {
                script {
                    sh '''
                    mkdir -p build-context
                    cd build-context

                    # Download the WAR file from Nexus
                    curl -o SimpleCustomerApp.war "$WAR_URL"

                    # Create Dockerfile
                    cat <<EOF > Dockerfile
                    FROM tomcat:9.0-jdk17
                    RUN rm -rf /usr/local/tomcat/webapps/*
                    COPY SimpleCustomerApp.war /usr/local/tomcat/webapps/SimpleCustomerApp.war
                    EXPOSE 8080
                    CMD ["catalina.sh", "run"]
                    EOF
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest build-context"
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up Docker build context..."
            sh "rm -rf build-context"
        }
    }
}
