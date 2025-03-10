variable "model" {
  description = "The name of the Juju model."
  type        = string
  default     = "jimm"
}

variable "name" {
  description = "The name of the Juju openfga application."
  type        = string
  default     = "openfga"
}

variable "units" {
  description = "The desired Juju unit count to deploy."
  type        = number
  default     = 1

  validation {
    condition     = var.units > 0
    error_message = "The unit count must be a positive integer."
  }
}

variable "trust" {
  description = "The status to grant the Juju application full access to the cluster."
  type        = bool
  default     = true
}

variable "charm" {
  description = "The application charm operator information."
  type = object({
    name : string
    channel : string
    base : string
  })
  default = {
    name    = "openfga-k8s"
    channel = "latest/stable"
    base    = "ubuntu@22.04"
  }
}

variable "postgresql_application_name" {
  type    = string
  default = "postgresql"
}
