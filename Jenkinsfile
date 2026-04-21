pipeline {
    agent any

    environment {
        IMAGE_NAME = "tawa123/infrastructure-platform"
        IMAGE_TAG  = "latest"
        PATH       = "/usr/local/bin:/opt/homebrew/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and push Docker image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker buildx build --platform linux/amd64 \
                          -t tawa123/infrastructure-platform:latest \
                          --push .
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                sh '''
                    cd ansible
                    ansible-playbook -i inventory.ini playbook.yml
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline succeeded - app is live at http://54.196.129.72"
        }
        failure {
            echo "Pipeline failed - check logs above"
        }
    }
}
