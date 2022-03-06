variable "s3_bucket_name" {
  description = "Unique name for s3 bucket"
  type        = string
  default     = "my-terraform-2022-lab-s3-bucket-edition2"
}

variable "acl" {
  description = "ACL settings either private or public"
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "All objects should be deleted, objects are not recoverable"
  type        = bool
  default     = false
}