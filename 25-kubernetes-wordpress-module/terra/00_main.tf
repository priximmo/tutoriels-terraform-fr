variable "mysql-dir" {}
variable "mysql-password" {}
variable "mysql-img" {}
variable "mysql-lbl" {}
variable "mysql-port" {}
variable "wordpress-dir" {}
variable "wordpress-port" {}
variable "wordpress-img" {}
variable "wordpress-host" {}
variable "wordpress-lbl" {}


provider "kubernetes" {
  load_config_file = true
}

resource "kubernetes_secret" "mysql" {
  metadata {
    name = "mysql-pass"
  }
  data = {
    password = var.mysql-password
  }
}


