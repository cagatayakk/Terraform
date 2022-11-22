data "aws_route53_zone" "my-hosted-zone" {
  name         = var.domain-name
}


resource "aws_route53_record" "www" {
  allow_overwrite = true
  zone_id = data.aws_route53_zone.my-hosted-zone.zone_id
  name    = var.bucket-name
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.statik-web.website_domain   
    zone_id                = aws_s3_bucket.my-bucket.hosted_zone_id
    evaluate_target_health = true
  }
}
