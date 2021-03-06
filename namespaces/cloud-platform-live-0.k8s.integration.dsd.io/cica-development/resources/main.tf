terraform {
  backend "s3" {}
}

provider "aws" {
  region = "eu-west-2"
}

module "ecr-repo" {
  source    = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=1.0"
  team_name = "cica"
  repo_name = "cicadevelopment"
}

resource "kubernetes_secret" "ecr-repo" {
  metadata {
    name      = "cica"
    namespace = "cica-development"
  }

  data {
    repo_url          = "${module.ecr-repo.repo_url}"
    access_key_id     = "${module.ecr-repo.access_key_id}"
    secret_access_key = "${module.ecr-repo.secret_access_key}"
  }
}
