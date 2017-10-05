variable "aws_region" {
  default = "us-east-1"
}

variable "keep" {
  default="100"
}

variable "cron" {
  default="0 * * * ? *"
}

variable "dry_run" {
  default = "true"
}

variable "repo_region" {
   default="us-east-1"
}

