terraform {
     backend "s3" {
       bucket       = "vamsi-bucket-for-training200825"
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
