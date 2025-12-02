pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_SESSION_TOKEN     = credentials('AWS_SESSION_TOKEN')
        AWS_DEFAULT_REGION    = "us-east-1"
    }

    stages {

        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/PrashanthSai-K/terraform-cicd.git'
                sh 'aws sts get-caller-identity'
            }
            post {
                always { echo "Cloning stage completed" }
                failure { echo "Cloning Failed" }
                success { echo "Cloned Git repo" }
            }
        }

        stage('Init') {
            steps {
                sh 'terraform init'
            }
            post {
                always { echo "Init stage completed" }
                failure { echo "Init Failed" }
                success { echo "Init successfully completed" }
            }
        }

        stage('Plan') {
            steps {
                sh """
                terraform plan \
                    -var instance_type=${instance_type} \
                    -var ami_id=${ami_id} \
                    -var aws_region=${aws_region} \
                    -var key_name=${key_name} \
                    -var vpc_id=${vpc_id} \
                    -out=tfplan
                """
            }
            post {
                always { echo "Planning stage completed" }
                failure { echo "Plan Failed" }
                success { echo "Plan successfully completed" }
            }
        }

        stage('Approval Required') {
            when {
                branch 'main'
            }
            steps {
                script {
                    timeout(time: 30, unit: 'MINUTES') {
                        input message: "Deploy Terraform plan to MAIN?", ok: "Deploy"
                    }
                }
            }
        }

        stage('Apply') {
            when {
                branch 'main'
            }
            steps {
                sh """
                terraform apply \
                    -var instance_type=${instance_type} \
                    -var ami_id=${ami_id} \
                    -var aws_region=${aws_region} \
                    -var key_name=${key_name} \
                    -var vpc_id=${vpc_id} \
                    --auto-approve
                """
            }
            post {
                always { echo "Apply stage completed" }
                failure { echo "Apply Failed" }
                success { echo "Terraform Applied successfully" }
            }
        }
    }
}
