@Library('devops-shared') _

pipeline {
    agent any

    environment {
        ARTIFACT_NAME = "DevOps-Assessment-1.0.jar"
        REPO_URL = "http://localhost:8081/artifactory/libs-release-local"
    }

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    prepareEnv()
                }
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Shulamit9292/DevOps-Assessment.git'
            }
        }

        stage('Build Artifact') {
            steps {
                sh './gradlew build'
            }
        }

        stage('Package and Upload') {
            steps {
                sh "mv build/libs/*.jar ${ARTIFACT_NAME}"
                sh "curl -u user:password -T ${ARTIFACT_NAME} ${REPO_URL}"
            }
        }
    }
}
