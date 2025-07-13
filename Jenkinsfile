pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
  }

  stages {
    stage('Debug Branch Name') {
      steps {
        echo "Branch detected: ${env.BRANCH_NAME}"
      }
    }

    stage('Build') {
      steps {
        sh './build.sh'
      }
    }

    stage('Push to Docker Hub') {
      when {
        expression {
          env.BRANCH_NAME == 'dev'
        }
      }
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker tag devops-static-app srihariops/guvi-project-dev:latest
            docker push srihariops/guvi-project-dev:latest
          '''
        }
      }
    }

    stage('Push to Prod Repo') {
      when {
        expression {
          env.BRANCH_NAME == 'main'
        }
      }
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker tag devops-static-app srihariops/guvi-project-prod:latest
            docker push srihariops/guvi-project-prod:latest
          '''
        }
      }
    }

  stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
  }
}

