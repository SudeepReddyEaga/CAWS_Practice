pipeline {
    agent any

    triggers {
        // Poll GitHub repository every 5 minutes for new commits
        pollSCM('H/5 * * * *')
    }

    environment {
        IMAGE_NAME     = 'sudeepkumarreddyeaga/caws-practice'
        IMAGE_TAG      = 'latest'
        CONTAINER_NAME = 'sudeep-webpage-app'
        APP_PORT       = '5000'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out latest code from GitHub...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}..."
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Deploy Container on AWS EC2') {
            steps {
                echo 'Deploying latest container...'
                sh '''
                    # Stop and remove previous container if it exists
                    docker stop ${CONTAINER_NAME} || true
                    docker rm -f ${CONTAINER_NAME} || true

                    # Run updated container
                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        --restart unless-stopped \
                        -p ${APP_PORT}:5000 \
                        ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Health Check') {
            steps {
                echo 'Verifying application health...'
                sh '''
                    sleep 3
                    curl -f http://localhost:${APP_PORT} || exit 1
                '''
            }
        }

        stage('Push to Docker Hub') {
            // Runs if 'dockerhub-creds' credentials ID exists in Jenkins
            when {
                environment name: 'ENABLE_DOCKER_PUSH', value: 'true'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline succeeded! Webpage is running at http://<EC2-PUBLIC-IP>:${APP_PORT}"
        }
        failure {
            echo "Pipeline failed! Check console logs for debugging."
        }
    }
}
