terraform {
     backend "s3" {
       bucket       = "Vamsi-bucket-20082025"
       key          = "Vamsi-terraform.tfstate"
       region       = "eu-west-2"
       use_lockfile = true
     }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = "eu-west-2" 
}
