pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_SESSION_TOKEN     = credentials('AWS_SESSION_TOKEN')
        AWS_DEFAULT_REGION    = "us-east-1"
    }

    parameters {
        string(name: 'instance_type', defaultValue: 't3.medium', description: 'EC2 instance type')
        string(name: 'ami_id', defaultValue: 'ami-0156001f0548e90b1', description: 'AMI ID')
        string(name: 'aws_region', defaultValue: 'us-east-1', description: 'AWS Region')
        string(name: 'key_name', defaultValue: 'sai-key-pair-name', description: 'EC2 Key Pair')
        string(name: 'vpc_id', defaultValue: 'vpc-019e65727b9d6b8e6', description: 'VPC ID to deploy into')
    }

    stages {


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
