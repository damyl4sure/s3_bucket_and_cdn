# README #

This README would normally document whatever steps are necessary to get your infrastructure up and running.


Step1: Add the .gitgnore file in the root directory to prevent unwanted files from being pushed to the bitbutcket 

Step2: Add Jenkinsfile in the root directory, it contains the pipeline steps to run terraform commands that will create a terraform workspac, deploy and destroy the infrastructure.

Step3: Modify the Jenkinsfile to suit the new project.

Step4: Create a new directory 'manifest' where all the terraform configuration files will reside.
- Follow the naming convention for the .tf files

- Ensure to add .tfvars files to override the variables for both staging and production environment.

- For staging variables, name the file 'c99-01-staging.tfvars'. For production variables, name the file 'c99-02-production.tfvars'.

Step5: 
- For staging environment imfrastrure deployment, push to the remote staging branch in bitbucket.

- For production environment imfrastrure deployment, push to the remote production branch in bitbucket.

Step6: After checking to each branch (either staging or production), the triggerred pipeline will request for either terraform apply or terraform destroy input. Login to jenkins and Select apply or destroy as the case may be.
