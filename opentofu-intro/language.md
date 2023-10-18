OpenTofu's language is its primary user interface. Configuration files you write in OpenTofu language tell OpenTofu what plugins to install, what infrastructure to create, and what data to fetch. OpenTofu language also lets you define dependencies between resources and create multiple similar resources from a single configuration block.

Below is the example for managing a docker container using OpenTofu.
You can also find the code in `demo.tf` file

```
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```


You can find more details about OpenTofu language at https://opentofu.org/docs/language/