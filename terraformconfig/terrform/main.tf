terraform {
  backend "s3"{
    bucket = "demo-application-backend-state-123"
    key= "backend_state_terraform_dev"
    region = "ap-south-1"
    dynamodb_table = "demo_application_lock"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

