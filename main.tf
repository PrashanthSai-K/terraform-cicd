resource "aws_s3_bucket" "example" {
  bucket = var.bucketname

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}
