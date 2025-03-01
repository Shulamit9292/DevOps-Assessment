@Library('devops-shared@main') _

pipeline {
    agent any

    environment {
        ARTIFACT_NAME = "DevOps-Assessment-1.0.jar"
        GIT_REPO_URL = "https://github.com/Shulamit9292/devops-pipeline-artifacts.git"
        CREDENTIALS_ID = "github-credentials"
    }

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    prepareEnv()
                }
            }
        }

        stage('Verify SCM Data') {
            steps {
                script {
                    echo "Verifying SCM data..."
                    echo "Commit Author: ${env.COMMIT_AUTHOR}"
                    echo "Commit Message: ${env.COMMIT_MESSAGE}"
                }
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-credentials',
                    url: 'https://github.com/Shulamit9292/DevOps-Assessment.git'
            }
        }

        stage('Build Artifact') {
            steps {
                sh 'chmod +x gradlew'
                sh './gradlew build'
            }
        }

        stage('Package and Upload to Git Repository') {
            steps {
                script {
                    // Prepare the artifact for upload
                    sh "mv build/libs/DevOps-Assessment-1.0.jar ${ARTIFACT_NAME}"

                    withCredentials([usernamePassword(credentialsId: env.CREDENTIALS_ID, usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                        sh 'git config --global http.postBuffer 524288000'
                        sh 'git config --global http.version HTTP/1.1'
                        // If the folder exists, delete it
                        sh 'rm -rf temp-repo'

                        // Clone the repository
                        sh 'git clone --depth=1 https://${GIT_USER}:${GIT_PASS}@github.com/Shulamit9292/devops-pipeline-artifacts.git temp-repo'

                        dir('temp-repo') {
                            // Set Git user name and email for Jenkins
                            sh 'git config --local user.name "Jenkins"'
                            sh 'git config --local user.email "jenkins@ci.com"'


                            // Copy the artifact
                            sh "cp ../${ARTIFACT_NAME} ./"

                            // Add to Git, commit, and push
                            sh 'git add ${ARTIFACT_NAME}'
                            sh 'git commit -m "Adding new artifact: ${ARTIFACT_NAME}" || echo "No changes to commit"'
                            sh 'git push https://${GIT_USER}:${GIT_PASS}@github.com/Shulamit9292/devops-pipeline-artifacts.git'
                        }
                    }
                }
            }
        }

        stage('Deploy using Ansible') {
            steps {
                script {
                    sh '''
                    docker exec -t ansible-container ansible-playbook -i /ansible/inventory /ansible/playbook.yml
                    '''
                }
            }
        }

    }
}
