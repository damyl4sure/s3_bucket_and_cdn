variable "tag_name" {
  description = "Tag variable used as a name of resource"
  type        = string
  default     = "s3_bucket_and_cdn"
}

variable "tag_purpose" {
  description = "Tag variable used as a prefix"
  type        = string
  default     = "s3_bucket_and_cdn_billing"
}