terraform {
  required_providers {
    juju = {
      source  = "registry.terraform.io/juju/juju"
      version = ">= 0.17.1"
    }
  }
}

provider "juju" {}

variable "client_id" {
  description = "client id for oauth provider"
  type        = string
}

variable "client_secret" {
  description = "client secret for oauth provider"
  type        = string
}

resource "juju_model" "jimm" {
  name = "jimm"
}

module "postgresql" {
  source     = "./modules/postgresql"
  depends_on = [juju_model.jimm]
}

module "openfga" {
  source     = "./modules/openfga"
  depends_on = [juju_model.jimm]
}

module "cert" {
  source     = "./modules/cert"
  depends_on = [juju_model.jimm]
}

module "traefik" {
  source            = "./modules/traefik"
  depends_on        = [juju_model.jimm]
  external_hostname = "jimm.localhost.com"
}

module "vault" {
  source     = "./modules/vault"
  depends_on = [juju_model.jimm]
}


module "jimm" {
  source          = "./modules/jimm"
  oauth_offer_url = ""
  client_id       = var.client_id
  client_secret   = var.client_secret
  jimm_config = {
    uuid        = "3f4d142b-732e-4e99-80e7-5899b7e67e59"
    dns_name    = "test-jimm.localhost"
    public_key  = "eaj1OMeHsd8OyDTqE+OOpkmWCNd1Py6mF1i3UD+VoCk=" # this will eventually be a secret
    private_key = "vx+aEalWSM524h9NAZcyZlUFvOLkiRN2J7K5uz9FW1c=" # this will eventually be a secret
  }
  depends_on = [juju_model.jimm]
}


