terraform {
  backend "s3" {
    bucket = "nm-s3-bucket"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region     = "us-east-2"
}

provider "docker" {}