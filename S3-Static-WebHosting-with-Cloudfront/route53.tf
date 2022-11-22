data "aws_route53_zone" "my-hosted-zone" {
  name         = var.domain-name
}

resource "aws_route53_record" "Arecord" {
  allow_overwrite = true
  zone_id = data.aws_route53_zone.my-hosted-zone.zone_id
  name    = var.bucket-name
  type    = "A"

  alias {
    name = aws_cloudfront_distribution.cloudfront-distribution.domain_name
    zone_id = aws_cloudfront_distribution.cloudfront-distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
