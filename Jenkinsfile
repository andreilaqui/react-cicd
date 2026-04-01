pipeline {
    agent any

    environment {
    //     // NETLIFY_AUTH_TOKEN = credentials('netlify-auth-token') // this guy is used automatically by the netlify CLI tool
    //     // NETLIFY_SITE_ID = credentials('netlify-site-id')
        AWS_DEFAULT_REGION = 'us-east-2'
        AWS_DOCKER_REGISTRY = '521495323881.dkr.ecr.us-east-2.amazonaws.com'
        APP_NAME = 'my-react-repo'
    }

    stages {
        // stage('Install Dependencies') {
        //     steps {
        //         sh 'npm install'
        //     }
        // }

        // stage('Build App') {
        //     steps {
        //         sh 'npm run build'
        //     }
        // }

        // stage('Deploy to Netlify') {
        //     steps {
        //         sh '''
        //         npx netlify deploy --prod --dir=dist --site=$NETLIFY_SITE_ID
        //         '''
        //         /* notes:
        //         npx - node package runner, installs and runs the netlify CLI tool
        //         netlify deploy - deploys the site to Netlify (like git push, or npm run)
        //         --prod - deploys to production (instead of a draft URL)
        //         --dir=dist - specifies the directory to deploy (my dist folder made by npm run build)
        //         --site=$NETLIFY_SITE_ID - specifies the Netlify site to deploy to, using the environment variable set above

        //         */
        //     }
        // }

        // stage('AWS'){
        //     agent{
        //         docker {
        //             image 'amazon/aws-cli'
        //             reuseNode true
        //             args '--entrypoint=""' // this allows the AWS CLI container to access the Docker daemon on the Jenkins host, enabling it to run Docker commands if needed
        //         }
        //     }
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'jenkins-s3', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
        //             sh'''
        //                 aws --version
        //                 aws s3 ls
        //                 aws s3 sync dist s3://andreilaqui-s3-cicd/
        //             '''
        //         }
        //     }
        // }
        
        

        stage('Build My Image') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    reuseNode true
                    args '-u root -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=""'
                    }
            }
            steps {
                 withCredentials([usernamePassword(credentialsId: 'jenkins-s3', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) 
                 {

                    sh '''
                        dnf install -y docker
                        docker build -t $AWS_DOCKER_REGISTRY/$APP_NAME .
                        docker images

                        # access ECR, username is AWS, get temporary password
                        aws ecr get-login-password | docker login --username AWS --password-stdin $AWS_DOCKER_REGISTRY
                        docker push $AWS_DOCKER_REGISTRY/$APP_NAME:latest

                    '''
                 }
            }
        }


        // stage('Deploy to AWS ECS'){
        //     agent{
        //         docker {
        //             image 'amazon/aws-cli'
        //             reuseNode true
        //             args '-u root --entrypoint=""'
        //         }
        //     }

        //     steps{
        //         withCredentials([usernamePassword(credentialsId: 'jenkins-s3', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
        //             sh '''
        //                 aws --version

        //                 yum install jq -y

        //                 LATEST_TD_REVISION=$( aws ecs register-task-definition --cli-input-json file://aws/task-definition.json | jq -r '.taskDefinition.revision' )
        //                 aws ecs update-service --cluster andrei-react-cicd-cluster --service react-cicd-service --task-definition react-cicd-json-task:$LATEST_TD_REVISION

        //             '''
        //         }
        //     }
        // }



    }
}