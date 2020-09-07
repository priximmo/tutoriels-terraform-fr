#!/usr/bin/bash

###############################################################
#  TITRE: 
#
#  AUTEUR:   Xavier
#  VERSION: 
#  CREATION:  
#  MODIFIE: 
#
#  DESCRIPTION: 
###############################################################



# Variables ###################################################



# Functions ###################################################



# Let's Go !! #################################################


rm -rf /disklv/
rm -rf terraform.tfstate*
virsh net-destroy vm_network_default
virsh net-undefine vm_network_default
virsh pool-destroy mycentos_default
virsh pool-undefine mycentos_default
virsh net-destroy vm_network_dev
virsh net-undefine vm_network_dev
virsh pool-destroy mycentos_dev
virsh pool-undefine mycentos_dev
virsh net-destroy vm_network_prod
virsh net-undefine vm_network_prod
virsh pool-destroy mycentos_prod
virsh pool-undefine mycentos_prod
