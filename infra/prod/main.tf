

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
  backend "s3" {
    bucket               = "onlinesocial-tf-state"
    key                  = "tf-state-prod"
    workspace_key_prefix = "tf-state-prod-env"
    region               = "us-east-1"
    encrypt              = true
    use_lockfile         = true
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      Contact     = var.contact
      ManagedBy   = "Terraform/Production"
    }
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

data "aws_region" "current" {}