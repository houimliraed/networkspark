
variable "tf-state-bucket" {
  description = "bucket holding the terrafrom state in aws"
  default     = "onlinesocial-tf-state"
}

variable "project" {
  description = "Project name for resources in AWS"
  default     = "onlinesocial"
}
variable "contact" {
  description = "contact tagg for resources in AWS"
  default     = "houimliraed@engineergrid.com"
}
