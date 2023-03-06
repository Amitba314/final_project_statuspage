# terraform {
#   backend "s3" {
#     bucket         = "only-gabay-project"
#     key            = "terraform.tfstate"
#     region         = "us-east-2"
#     access_key     = ${{ secrets.AMIT_ACCESS_KEY_ID }}
#     secret_key     = ${{ secrets.AMIT_SECRET_ACCESS_KEY }}
#   }
# }
