data "juju_model" "model" {
  name = var.model
}

resource "juju_application" "traefik" {
  model = data.juju_model.model.name
  name  = var.name
  trust = var.trust
  units = var.units

  charm {
    name    = var.charm.name
    channel = var.charm.channel
    base    = var.charm.base
  }

  config = {
    external_hostname = var.external_hostname
    routing_mode      = var.routing_mode
  }
}
