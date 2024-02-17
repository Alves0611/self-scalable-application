provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Module"     = "Auto Scaling App"
      "ManagedBy"  = "Terraform"
    }
  }
}