# main.tf

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15" # Use a recent version
    }
  }
}

provider "docker" {
  # Configuration options can be added here if needed,
  # but defaults often work for local Docker Desktop.
}

# Define a Docker Image resource
# This tells Terraform to ensure the 'nginx:latest' image is pulled locally.
resource "docker_image" "nginx_image" {
  name = "nginx:1.21" # Use a specific version
  keep_locally = true # Keep the image even after Terraform destroys resources that use it
}

# Define a Docker Container resource
# This tells Terraform to create and manage an Nginx container.
resource "docker_container" "nginx_container" {
  # Use the image managed by the docker_image resource above
  image = docker_image.nginx_image.name # Reference the image name

  name  = "terraform-nginx-example" # Name for the container
  ports {
    internal = 80 # Container port
    external = 8088 # Host port to map to
  }
}
