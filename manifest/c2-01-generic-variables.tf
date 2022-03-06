# Provisioning region
variable "aws_region" {
  description = "Region in which AWS resources would be created"
  type        = string
  default     = "eu-west-1"
}

variable "aws_profile" {
  description = "AWS configure profile accesskey & secret ID"
  type        = string
  default     = "lab2022"
}