%title: Terraform
%author: xavki


# Terraform : remote_exec / SSH


<br>


* remote_exec > local_exec distant (ssh)

<br>


variable "host" {}
resource "null_resource" "ssh_target" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.ssh_host
    private_key = file("/root/.ssh/id_rsa")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -qq >/dev/null",
      "sudo apt install -qq -y nginx >/dev/null"
    ]
  }
}
