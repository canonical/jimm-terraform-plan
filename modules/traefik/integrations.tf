resource "juju_integration" "ingress_cert" {
  model = var.model

  application {
    name     = juju_application.traefik.name
    endpoint = "certificates"
  }

  application {
    name     = var.cert_application_name
    endpoint = "certificates"
  }
}
