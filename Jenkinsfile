#!/usr/bin/env 

/**

Jenkinsfile pipeline to deploy infrastructure using terraform

*/
import java.util.Date
import groovy.json.*
def repoName = 's3_bucket_and_cdn'
def projectName = ''
def folderName = "DevOps"

def isProduction = env.BRANCH_NAME == 'production'
def isStaging = env.BRANCH_NAME == 'staging'
def start = new Date()
def err = null

String jobInfoShort = "${env.JOB_NAME} ${env.BUILD_DISPLAY_NAME}"
String jobInfo = "${env.JOB_NAME} ${env.BUILD_DISPLAY_NAME} \n${env.BUILD_URL}"
String buildStatus
String timeSpent

currentBuild.result = "SUCCESS"



try {
    node {
        def buildNumber = env.BUILD_NUMBER
        def workspace = env.WORKSPACE
        def buildUrl = env.BUILD_URL
        def branchName = env.BRANCH_NAME

        echo "workspace directory is $workspace"
        echo "build URL is $buildUrl"
        echo "branch name id $branchName"
        echo "build Number is $buildNumber"

        stage ("Clean Workspace"){
            deleteDir()            
        }

        // stage('initializing'){
        //     slackSend (color: 'good', message: "Initializing terraform process for `${repoName}` ...")
        // }
        stage ('Checkout') {
            checkout scm
        }
        stage ('Run terraform init') {
            try {
                sh 'terraform -chdir=manifest init'
                //slackSend(color: "good", message: "terraform init successful")
            }
            catch(error) {
                sh "echo 'terraform init failed with error: ${error}' "
                //slackSend(color: "danger", message: "terraform init failed with error: ${error}")
                throw error
            }
       }
        if(isStaging){
            stage ('Run terraform validate') {
                sh "terraform -chdir=manifest validate"
                //slackSend(color: "good", message: "terraform validate successful")
            }
            // catch(error) {
            //     slackSend(color: "danger", message: "terraform validate failed with error: ${error}")
            //     throw error
            // }

            stage ('Create Terraform Workspace for Staging environment or select workspace if it already exist') {
                sh "terraform -chdir=manifest workspace select $env.BRANCH_NAME || terraform -chdir=manifest workspace new $env.BRANCH_NAME"
                //slackSend(color: "good", message: "terraform create staging workspace successful")
            }

            stage ('Run terraform plan') {
                sh 'terraform -chdir=manifest plan -var-file="c99-01-staging.tfvars"'
                //slackSend(color: "good", message: "terraform plan successful")
            }

            stage ('Run terraform apply'){
                def ACTION_INPUT = input(
                    message: 'Select either Apply or Destroy Action',
                    parameters: [ 
                        [$class: 'ChoiceParameterDefinition', 
                            choices: "Terraform Apply\nTerraform Destroy",
                            description: 'Choose whether to perform either terraform apply or destroy action', 
                            name: 'ACTION']
                            ])                   

                    if (ACTION_INPUT == "Terraform Apply") {
                        sh 'terraform -chdir=manifest apply --auto-approve -var-file="c99-01-staging.tfvars"'
                        //slackSend (color: 'good', message: ":fire: Nice work! `${repoName}` deployement successful")
                    }

                    else if (ACTION_INPUT == "Terraform Destroy") {
                        sh 'terraform -chdir=manifest destroy --auto-approve -var-file="c99-01-staging.tfvars"'
                        //slackSend (color: 'good', message: ":fire: Infrastucture destroyed! `${repoName}` destroy successful")
                    }

            }
                
        }
        
        if(isProduction){
            stage ('Run terraform validate') {
                sh "terraform -chdir=manifest validate"
                //slackSend(color: "good", message: "terraform validate successful")
            }
            // catch(error) {
            //     slackSend(color: "danger", message: "terraform validate failed with error: ${error}")
            //     throw error
            // }

            stage ('Create Terraform Workspace for Production environment or select workspace if it already exist') {
                sh "terraform -chdir=manifest workspace select $env.BRANCH_NAME || terraform -chdir=manifest workspace new $env.BRANCH_NAME"
                //slackSend(color: "good", message: "terraform create production workspace successful")
            }

            stage ('Run terraform plan') {
                sh 'terraform -chdir=manifest plan -var-file="c99-02-production.tfvars"'
                //slackSend(color: "good", message: "terraform plan successful")
            }

            stage ('Run terraform apply'){
                def ACTION_INPUT = input(
                    message: 'Select either Apply or Destroy Action',
                    parameters: [ 
                        [$class: 'ChoiceParameterDefinition', 
                            choices: "Terraform Apply\nTerraform Destroy",
                            description: 'Choose whether to perform either terraform apply or destroy action', 
                            name: 'ACTION']
                            ])                   

                    if (ACTION_INPUT == "Terraform Apply") {
                        sh 'terraform -chdir=manifest apply --auto-approve -var-file="c99-02-production.tfvars"'
                        //slackSend (color: 'good', message: ":fire: Nice work! `${repoName}` deployement successful")
                    }
                    
                    else if (ACTION_INPUT == "Terraform Destroy") {
                        sh 'terraform -chdir=manifest destroy --auto-approve -var-file="c99-02-production.tfvars"'
                        //slackSend (color: 'good', message: ":fire: Infrastucture destroyed! `${repoName}` destroy successful")
                    }

            }
                
        }

    }
    
} catch (caughtError) {
    err = caughtError
    currentBuild.result = "FAILURE"
} finally {
    timeSpent = "\nTime spent: ${timeDiff(start)}"
    if (err) {
        //slackSend (color: 'danger', message: ":disappointed: _Build failed_: ${jobInfo} ${timeSpent}")
        throw err
    } else {
        if (currentBuild.previousBuild == null) {
            buildStatus = '_First time build_'
        } else if (currentBuild.previousBuild.result == 'SUCCESS') {
            buildStatus = '_Build complete_'
        } else {
            buildStatus = '_Back to normal_'
        }
        //slackSend (color: 'good', message: "${buildStatus}: ${jobInfo} ${timeSpent}")
    }
}

def timeDiff(st) {
    def delta = (new Date()).getTime() - st.getTime()
    def seconds = delta.intdiv(1000) % 60
    def minutes = delta.intdiv(60 * 1000) % 60
    return "${minutes} min ${seconds} sec"
}