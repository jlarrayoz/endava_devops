#!/usr/bin/env bash

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }
fn_fail() { echo "Opcion erronea."; exit 1; }
fn_bye() { echo "Hasta luego."; exit 0; }


#Mensaje de espera
wait_message() {
  redprint 'Presione una tecla para continuar'
  read -p ""
}

#Instalar java
install_java() {
  echo ""
	blueprint 'Verificando instalación previa de JAVA ....'
	
  #Se usa el comando type -p para determinar si java es un binario en el PATH
  if type -p java; then
    echo se encontro java en el PATH
    _java=java
  #Si no lo encuentro en el path, me fijo si JAVA_HOME no esta vacio, y si no esta vacio, me fijo si JAVA_HOME/bin/java es un ejecutable  
  #https://devhints.io/bash#conditionals
  elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo se encontro el ejecutable de java en JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
  else
    echo "no java"
  fi

  #Muestro la version de java que esta instalada
  if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    redprint 'No se va a instalar java porque ya esta instalado'
  else
    #Se procede a instalar java
    greenprint 'Instalando java ...'
    sudo apt-get install -y openjdk-11-jre
  fi

  wait_message

}

#Funcion para instalar Jenkins
install_jenkins() {

  echo ""
	blueprint 'Verificando instalación previa de JENKINS ....'
	
  #Se usa el comando type -p para determinar si existe el binario de jenkins
  if type jenkins; then
    echo se encontro jenkins en el PATH
    _jenkins=existe
    redprint 'No se va a instalar JENKINS porque ya esta instalado'
  else
    echo "no existe instalacion previa de jenkins"
    _jenkins=""
  fi

  if [[ ! "$_jenkins" ]]; then
    #Se procede a instalar JENKINS
    greenprint 'Instalando Jenkins ...'

    #Instalamos las sources
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
      /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian binary/ | sudo tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null
    
    #Instalamos jenkins
    sudo apt-get update
    sudo apt-get install jenkins
    
    #Para que se pueda hacer sudo desde los pipelines de jenkins
    sudo usermod -a -G sudo jenkins
    
    greenprint 'Reiniciando servicio de jenkins ...'
    sudo systemctl restart jenkins 
  fi

  wait_message
  
}

#Muestra el password por defecto de jenkins a consola
print_password() {

  PASSWORD_FILE=/var/lib/jenkins/secrets/initialAdminPassword
  echo ""
	blueprint 'Verificando si existe archivo de password de JENKINS ....'
  if sudo test -f "$PASSWORD_FILE"; then
    greenprint 'El password de jenkins es:'
    redprint $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
  else
    redprint 'NO existe el archivo de password'
  fi

  wait_message
}

install_docker() {
 echo ""
	blueprint 'Verificando instalación previa de DOCKER ....'
	
  #Se usa el comando type -p para determinar si java es un binario en el PATH
  if type docker; then
    echo se encontro docker en el PATH
    redprint 'Docker ya se encuentra instalado'
  else
    greenprint 'Instalando docker ...'
    #Instalo docker
    #No instalo la version que viene por defecto con Ubuntu 18.04.
    #Agrego el repo e instalo la ultima disponible para la version del S.O
    sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"  

    #Update de los packetes de la VM
    sudo apt-get update

    #Me aseguro que se instale la version del repo agregado previamente
    sudo apt-cache policy docker-ce

    #Instalo docker y sus accesorios
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin  
    
    #Agrego el usuario del servicio de jenkins al grupo de docker
    sudo usermod -a -G docker jenkins

    redprint '**** Advertencia: SI EL SERVICIO DE JENKINS ESTA CORRIENDO SE DEBE REINICIAR ***' 
  fi

  wait_message

}

#Instalacion del plugin Configuration as Code de Jenkins
#Para la instalacion vamos a usar jenkins-cli
#https://www.jenkins.io/doc/book/managing/plugins/#install-with-cli
install_plugins() {

  #VAR con el PATH del archivo jar  
  FILE_JAR=$HOME/jenkins-cli.jar
  
  #VAR con ep PATH del plugin
  PLUGIN_DIR=/var/lib/jenkins/plugins

  #PATH a los diferentes plugins a instalar 
  PLUGIN_JCAC=$PLUGIN_DIR/configuration-as-code
  PLUGIN_DOCKER=$PLUGIN_DIR/docker-plugin
  PLUGIN_DOCKER_WF=$PLUGIN_DIR/docker-workflow

  #Me paro en el home
  cd $HOME

  #Obtengo el jar de la cli si ya no lo baje anteriormente
  greenprint 'Instalando jenkins-cli...'
  if [[ ! -f $FILE_JAR ]]; then
    #Descargo el jar de la instancia levantada ed jenkins
    greenprint 'Descargando jar de la cli ...'
    wget http://localhost:8080/jnlpJars/jenkins-cli.jar
  else
    redprint 'Ya existe jar de jenkins-cli'
  fi
  
  #Instalo el plugin de configuration as code si ya no esta instalado
  greenprint 'Instalando plugin JCAC...'
  if [[ ! -d $PLUGIN_JCAC ]]; then
    
    #Instalo el plugin usando jenkins-cli
    java -jar jenkins-cli.jar -s http://localhost:8080/ -auth @credentials install-plugin configuration-as-code

  else
    redprint 'El plugin JCAC ya se encuentra instalado'
  fi

  greenprint 'Instalando plugin DOCKER...'
  if [[ ! -d $PLUGIN_DOCKER ]]; then
    
    #Instalo plugin de docker
    java -jar jenkins-cli.jar -s http://localhost:8080/ -auth @credentials install-plugin docker-plugin:1.2.10

  else
    redprint 'El plugin docker ya se encuentra instalado'
  fi

  greenprint 'Instalando plugin DOCKER-WF...'
  if [[ ! -d $PLUGIN_DOCKER_WF ]]; then
    
    #Instalo plugin de docker pipeline
    java -jar jenkins-cli.jar -s http://localhost:8080/ -auth @credentials install-plugin docker-workflow:521.v1a_a_dd2073b_2e

  else
    redprint 'El plugin docker-wf ya se encuentra instalado'
  fi
 
  #Una vez instalado el plugin reiniciamos el servicio de jenkins
  greenprint 'Reiniciando servicio de jenkins ...'
  sudo systemctl restart jenkins 

  wait_message
}

#Menu principal
menu(){
clear
echo -ne "
$(blueprint 'MENU INSTALACION DE JENKINS')

$(greenprint '1)') Instalar JAVA
$(greenprint '2)') Instalar Docker
$(greenprint '3)') Instalar Jenkins
$(greenprint '4)') Mostrar password por defecto
$(greenprint '5)') Instalar plugin JCAC, DOCKER, DOCKER-WF desde la CLI
$(greenprint '0)') Salir
$(blueprint 'Elija una opción:') "
        read a
        case $a in
	        1) install_java ; menu ;;
          2) install_docker ; menu ;;
	        3) install_jenkins ; menu ;;
	        4) print_password ; menu ;;
          5) install_plugins ; menu ;;
			    0) fn_bye ;;
			    *) fn_fail ;;
        esac
}

#Se ejecuta el menu
menu