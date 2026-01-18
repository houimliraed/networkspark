

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


#### policy for ecr repo

data "aws_iam_policy_document" "ecr" {

  statement {
    effect = "Allow"
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:BatchGetImage"
    ]
    resources = [
      aws_ecr_repository.onlinesocial_backend.arn
    ]
  }
  statement {
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

}

resource "aws_iam_policy" "ecr" {
  name        = "${aws_iam_user.cd.name}-ecr"
  description = "Allow the cd user for the ecr repo of the backend"
  policy      = data.aws_iam_policy_document.ecr.json
}

resource "aws_iam_user_policy_attachment" "ecr" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.ecr.arn

}

# networking permissions

data "aws_iam_policy_document" "ec2" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeRegions",
      "ec2:DescribeVpcs",
      "ec2:CreateTags",
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:DescribeSecurityGroups",
      "ec2:DeleteSubnet",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DetachInternetGateway",
      "ec2:DescribeInternetGateways",
      "ec2:DeleteInternetGateway",
      "ec2:DetachNetworkInterface",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeRouteTables",
      "ec2:DeleteRouteTable",
      "ec2:DeleteVpcEndpoints",
      "ec2:DisassociateRouteTable",
      "ec2:DeleteRoute",
      "ec2:DescribePrefixLists",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeNetworkAcls",
      "ec2:AssociateRouteTable",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:CreateSecurityGroup",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:CreateVpcEndpoint",
      "ec2:ModifySubnetAttribute",
      "ec2:CreateSubnet",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateInternetGateway",
      "ec2:AttachInternetGateway",
      "ec2:ModifyVpcAttribute",
      "ec2:RevokeSecurityGroupIngress",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2" {
  name        = "${aws_iam_user.cd.name}-ec2"
  description = "Allow user to manage EC2 resources."
  policy      = data.aws_iam_policy_document.ec2.json
}

resource "aws_iam_user_policy_attachment" "ec2" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.ec2.arn
}

# permissions for rds 
######
# Policy for RDS access 
#####

data "aws_iam_policy_document" "rds" {
  statement {
    effect = "Allow"
    actions = [
      "rds:DescribeDBSubnetGroups",
      "rds:DescribeDBInstances",
      "rds:CreateDBSubnetGroup",
      "rds:DeleteDBSubnetGroup",
      "rds:ModifyDBSubnetGroup",
      "rds:CreateDBInstance",
      "rds:DeleteDBInstance",
      "rds:ListTagsForResource",
      "rds:ModifyDBInstance",
      "rds:AddTagsToResource",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "rds" {
  name        = "${aws_iam_user.cd.name}-rds"
  description = "Allow user to manage RDS resources."
  policy      = data.aws_iam_policy_document.rds.json
}

resource "aws_iam_user_policy_attachment" "rds" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.rds.arn
}

