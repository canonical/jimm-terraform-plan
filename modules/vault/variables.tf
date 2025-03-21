variable "model" {
  description = "The name of the Juju model."
  type        = string
  default     = "jimm"
}

variable "name" {
  description = "The name of the Juju vault application."
  type        = string
  default     = "vault"
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
    name    = "vault-k8s"
    channel = "1.16/stable"
    base    = "ubuntu@22.04"
  }
}
