variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}

module "docker_install" {
  source 	= "./modules/docker_install"
  ssh_host  	= var.ssh_host
  ssh_user  	= var.ssh_user
  ssh_key  	= var.ssh_key
}
module "docker_run" {
  source 	= "./modules/docker_run"
  ssh_host	= var.ssh_host
}

output "ip_container" {
  value = module.docker_run.ip_docker
}
