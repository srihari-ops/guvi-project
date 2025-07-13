pipeline {
  agent any

  environment {
    BRANCH_NAME = "${env.GIT_BRANCH.replaceFirst(/^origin\\//, '')}"
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
        echo "Pushing to Dev Repo..."
        sh '''
          echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
          docker tag devops-static-app srihariops/guvi-project-dev:latest
          docker push srihariops/guvi-project-dev:latest
        '''
      }
    }

    stage('Push to Prod Repo') {
      when {
        expression {
          env.BRANCH_NAME == 'main'
        }
      }
      steps {
        echo "Pushing to Prod Repo..."
        sh '''
          echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
          docker tag devops-static-app srihariops/guvi-project-prod:latest
          docker push srihariops/guvi-project-prod:latest
        '''
      }
    }

  stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
  }
}
