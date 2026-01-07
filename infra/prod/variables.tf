
variable "tf-state-bucket" {

  description = "bucket holding terraform state"
  default     = "onlinesocial-tf-state"

}

variable "prefix" {
  description = "prefix for resources in AWS"
  default     = "onlinesocial"

}

variable "project" {

  description = "project tag for resources in AWS"
  default     = "onlinesocial"

}
variable "contact" {
  description = "contact for tagged resouces in AWS"
  default     = "houimliraed@engineergrid.com"
}
variable "region" {
  description = "aws region instead of hardcoding it"

}

