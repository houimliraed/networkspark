
# creating the ecr repo for the backend image of the application

resource "aws_ecr_repository" "onlinesocial_backend" {

    name = "onlinesocial_backend"
    image_tag_mutability = "MUTABLE"
    force_delete = false

    image_scanning_configuration {
      scan_on_push = false
    }
  
}