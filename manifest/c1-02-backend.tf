terraform {
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terralab-2022-form"
    key    = "s3_bucket_and_cdn_/terraform.tfstate"
    region = "eu-west-1"

    # Enable state locking with AWS DynamoDB     
    # For State Locking (LockID)
    dynamodb_table = "terralab-2022-form"
  }
}