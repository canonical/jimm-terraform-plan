resource "juju_integration" "openfga_postgresql" {
  model = var.model

  application {
    name     = juju_application.openfga.name
    endpoint = "database"
  }

  application {
    name = var.postgresql_application_name
  }
}
