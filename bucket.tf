terraform {
  backend "s3" {
    bucket         = "only-gabay-project"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    access_key     = "AKIAVDQNLGLNKUZUVOSJ"
    secret_key     = "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"
  }
}
