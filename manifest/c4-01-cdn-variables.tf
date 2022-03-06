variable "cdn_aliases" {
  description = "Unique website hostname for CDN alaise"
  type        = list(string)
  default     = ["mysite.terragonbase.com", "yoursite.example.com"]
}