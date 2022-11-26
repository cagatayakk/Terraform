variable "num_of_buckets" {
  default = 2
}


variable "users" {
  default = ["santino", "michael", "fredo"]
}



resource "aws_s3_bucket" "tf-s3" {
  bucket = "var.s3_bucket_name.${count.index}"
  count = var.num_of_buckets
  count = var.num_of_buckets != 0 ? var.num_of_buckets : 1
  for_each = toset(var.users)
  bucket   = "example-tf-s3-bucket-${each.value}"
}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}

output "uppercase_users" {
  value = [for user in var.users : upper(user) if length(user) > 6]
}
