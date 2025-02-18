@Library('devops-shared@main') _

pipeline {
    agent any

    environment {
        ARTIFACT_NAME = "DevOps-Assessment-1.0.jar"
        GIT_REPO_URL = "https://github.com/Shulamit9292/devops-pipeline-artifacts.git"
        CREDENTIALS_ID = "github-credentials" // Credentials ID for GitHub
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

                    // Set up Git credentials and upload the artifact
                    withCredentials([usernamePassword(credentialsId: env.CREDENTIALS_ID, usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                        // Clone the artifact repository
                        sh "git clone ${GIT_REPO_URL} temp-repo"

                        // Copy the artifact to the repository
                        sh "cp ${ARTIFACT_NAME} temp-repo/"

                        // Change to the repository directory, add and commit the file
                        dir('temp-repo') {
                            sh "git config user.name 'Jenkins'"
                            sh "git config user.email 'jenkins@ci.com'"
                            sh "git add ${ARTIFACT_NAME}"
                            sh "git commit -m 'Adding new artifact: ${ARTIFACT_NAME}'"
                            sh "git push https://${GIT_USER}:${GIT_PASS}@github.com/Shulamit9292/devops-pipeline-artifacts.git"
                        }
                    }
                }
            }
        }
    }
}
