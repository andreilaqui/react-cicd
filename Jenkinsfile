pipeline {
    agent any

    environment {
        NETLIFY_AUTH_TOKEN = credentials('netlify-auth-token') // this guy is used automatically by the netlify CLI tool
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

        stage('Deploy to Netlify') {
            steps {
                sh '''
                npx netlify deploy --prod --dir=dist --site=$NETLIFY_SITE_ID
                '''
                /*
                npx - node package runner, installs and runs the netlify CLI tool
                netlify deploy - deploys the site to Netlify (like git push, or npm run)
                --prod - deploys to production (instead of a draft URL)
                --dir=dist - specifies the directory to deploy (my dist folder made by npm run build)
                --site=$NETLIFY_SITE_ID - specifies the Netlify site to deploy to, using the environment variable set above

                */
            }
        }
    }
}