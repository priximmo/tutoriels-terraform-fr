variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}

module "install" {
  source        = "./modules/install_docker"
  ssh_host      = var.ssh_host
  ssh_key       = var.ssh_key
  ssh_user      = var.ssh_user
}

