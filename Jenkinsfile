pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git branch: 'dev', url: 'https://github.com/srihari-ops/guvi-project.git'
            }
        }
        stage('Build') {
            steps {
                sh './build.sh'
            }
        }
        stage('Push to Docker Hub') {
            when {
                branch 'dev'
            }
            steps {
                sh 'sudo docker tag devops-static-app srihariops/guvi-project-dev:latest'
                sh 'sudo docker push srihariops/guvi-project-dev:latest'
            }
        }
        stage('Push to Prod Repo') {
            when {
                branch 'master'
            }
            steps {
                sh 'sudo docker tag devops-static-app srihariops/guvi-project-prod:latest'
                sh 'sudo docker push srihariops/guvi-project-prod:latest'
            }
        }
    }
}

