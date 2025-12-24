

# iam for the deployement user

resource "aws_iam_user" "cd" {
    name = "onlinesocial-cd"
}
resource "aws_iam_access_key" "cd" {
    user = aws_iam_user.cd.name 
}

data "aws_iam_policy_document" "tf_backend" {

    statement {
      effect = "Allow"
      actions = ["s3:ListBucket"]
      resources = ["arn:aws:s3:::${var.tf-state-bucket}"]
    }
    statement {
      effect = "Allow"
      actions = [ "s3:GetObject","s3:PutObject","s3:DeleteObject" ]
      resources = [ 
        "arn:aws:s3:::${var.tf-state-bucket}/tf-state-prod/*",
        "arn:aws:s3:::${var.tf-state-bucket}/tf-state-prod-env/*"
       ]
    }

}