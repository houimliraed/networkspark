

output "cd_user_access_key_id" {

  value       = aws_iam_access_key.cd.id
  description = "AWS access key Id for CD user"

}

output "cd_user_access_key_secret" {
  value       = aws_iam_access_key.cd.secret
  description = "AWS secret key for CD user"
  sensitive   = true
}

output "ecr_repo_backend" {
  description = "the ECR repo URL for the backend app"
  value = aws_ecr_repository.onlinesocial_backend.repository_url
}