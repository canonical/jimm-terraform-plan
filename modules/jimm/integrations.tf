### Integrations ###
resource "juju_integration" "jimm_openfga" {
  model = var.model

  application {
    name     = juju_application.jimm.name
    endpoint = "openfga"
  }

  application {
    name = var.openfga_application_name
  }
}

resource "juju_integration" "jimm_ingress" {
  model = var.model

  application {
    name     = juju_application.jimm.name
    endpoint = "ingress"
  }

  application {
    name = var.ingress_application_name
  }
}

resource "juju_integration" "jimm_vault" {
  model = var.model

  application {
    name     = juju_application.jimm.name
    endpoint = "vault"
  }

  application {
    name = var.vault_application_name
  }
}

resource "juju_integration" "jimm_postgresql" {
  model = var.model

  application {
    name     = juju_application.jimm.name
    endpoint = "database"
  }

  application {
    name = var.postgresql_application_name
  }
}

resource "juju_integration" "jimm_oauth" {
  model = var.model
  application {
    name     = juju_application.jimm.name
    endpoint = "oauth"
  }

  application {
    name = juju_application.oauth-external-idp-integrator.name
  }
}

