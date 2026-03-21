pipeline {
    agent any

    environment {
        NETLIFY_AUTH_TOKEN = credentials('netlify-auth-token')
        NETLIFY_SITE_ID = credentials('netlify-site-id')
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build App') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Check Netlify Variables') {
            steps {
                sh '''
                [ -n "$NETLIFY_AUTH_TOKEN" ] && echo "NETLIFY_AUTH_TOKEN is set"
                [ -n "$NETLIFY_SITE_ID" ] && echo "NETLIFY_SITE_ID is set"
                '''
            }
        }
    }
}