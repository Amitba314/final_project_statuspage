terraform {
  backend "s3" {
    bucket         = "statuspage-s3"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    access_key     = "AKIAX7K52CAD6NPNZBWI"
    secret_key     = "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
"
  }

}
