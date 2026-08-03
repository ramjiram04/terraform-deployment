pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
        disableConcurrentBuilds()
        timestamps()
    }

    environment {
        TF_IN_AUTOMATION = 'true'
        TF_INPUT         = 'false'
    }

    stages {
        stage('Checkout') {
            steps {
                deleteDir()
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false -reconfigure'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform fmt -check -recursive'
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -input=false -out=tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
                sh 'terraform show -json tfplan > tfplan.json'
                sh 'sha256sum tfplan > tfplan.sha256'
                archiveArtifacts artifacts: 'tfplan,tfplan.txt,tfplan.json,tfplan.sha256', fingerprint: true
            }
        }

        stage('Approval') {
            steps {
                input id: 'cloud360-apply-approval', message: 'Cloud360 user approval is required to apply this saved Terraform plan.', ok: 'Apply approved plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'sha256sum -c tfplan.sha256'
                sh 'terraform apply -input=false -auto-approve tfplan'
                sh 'terraform output -json > terraform-output.json'
                archiveArtifacts artifacts: 'terraform-output.json', fingerprint: true
            }
        }
    }
}
