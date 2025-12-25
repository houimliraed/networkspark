

# iam for the deployement user

resource "aws_iam_user" "cd" {
  name = "onlinesocial-cd"
}
resource "aws_iam_access_key" "cd" {
  user = aws_iam_user.cd.name
}

# the policy document declaration 

data "aws_iam_policy_document" "tf_backend" {

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.tf-state-bucket}"]
  }
  statement {
    effect  = "Allow"
    actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = [
      "arn:aws:s3:::${var.tf-state-bucket}/tf-state-prod/*",
      "arn:aws:s3:::${var.tf-state-bucket}/tf-state-prod-env/*"
    ]
  }

}

# the actual policy creation

resource "aws_iam_policy" "tf_backend" {
  name        = "${aws_iam_user.cd.name}-tf-s3"
  description = "Allow user to use s3 for terraform backend resource"
  policy      = data.aws_iam_policy_document.tf_backend.json
}

# link the policy to the cd user

resource "aws_iam_user_policy_attachment" "tf_backend" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.tf_backend.arn

}