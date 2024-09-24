terraform {
  backend "s3" {
    bucket = "scramble-backup-s3-bucket"
    key    = "Infrastructure_main/terraform.tfstate"
    region = "us-east-1"
  }
}
