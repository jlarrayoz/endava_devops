# Iniciar vagrant (crea archivo Vagrantfile por defecto)
vagrant init ubuntu/bionic64

# Agregar una imagen de vm sin crear el archivo Vagrantfile
vagrant box add hashicorp/bionic64

# Levanta la VM
vagrant up

# Destruir la vm
vagrant destroy

# Ver las imagenes instaladas
vagrant box list

# Eliminar una imagen
vagrant box remove hashicorp/bionic64

# Eliminar una version especifica de una imagen
vagrant box remove ubuntu/bionic64 --box-version 20220902.0.0

# Si se toca el archivo vagrantfile, para que tome devuelta la config
vagrant reload
