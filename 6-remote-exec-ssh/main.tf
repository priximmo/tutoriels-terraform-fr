variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}
resource "null_resource" "ssh_target" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.ssh_host
    private_key = file(var.ssh_key)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -qq >/dev/null",
      "sudo apt install -qq -y nginx >/dev/null"
    ]
  }
  provisioner "file" {
    source      = "nginx.conf"
    destination = "/tmp/default"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp -a /tmp/default /etc/nginx/sites-available/default",
      "sudo systemctl restart nginx"
    ]
  }
  provisioner "local-exec" {
    command = "curl ${var.ssh_host}:667"
  }
}
output "host" {
value = var.ssh_host
}
output "user" {
value = var.ssh_user
}
output "key" {
value = var.ssh_key
}

