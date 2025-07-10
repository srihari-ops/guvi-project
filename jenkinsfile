pipeline {
  agent any
  stages {
    stage('Clone') {
      steps {
        git branch: 'dev', url: 'https://github.com/srihari-ops/devops-build.git'
      }
    }
    stage('Build Image') {
      steps {
        sh './build.sh'
      }
    }
    stage('Push to DockerHub') {
      steps {
        sh 'docker tag guvi-project-react-app srihariops/guvi_reactapp_dev:latest'
	sh 'docker tag guvi-project-react-app srihariops/guvi_reactapp_prod:latest'
	sh 'docker push srihariops/guvi_reactapp_prod'
        sh 'docker push srihariops/guvi_reactapp_dev'
      }
    }
    stage('Deploy to AWS') {
      steps {
        sh './deploy.sh'
      }
    }
  }
}

