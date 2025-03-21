data "juju_model" "model" {
  name = var.model
}

resource "juju_application" "jimm-cert" {
  model = data.juju_model.model.name
  name  = var.name
  trust = var.trust
  units = var.units

  charm {
    name    = var.charm.name
    channel = var.charm.channel
    base    = var.charm.base
  }
}

