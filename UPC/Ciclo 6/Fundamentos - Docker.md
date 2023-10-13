# Play with docker (labs.play-with-docker.com)

## Create Instance

### General commands

clear
(limpia pantalla, si no sabes ese comando eres noob)

docker version
(muestra la version de docker)

docker images
(lista imagenes que se descargaron desde docker hub, hasta esta instancia)

docker container ls
docker ps
(lista las imagenes que estan corriendo, Oliver dice q la segunda forma va a morir)

docker container ls -a
(lista las imagenes que han corrido, como un log)

docker container stop <image id/>
(para la imagen con ese id, la id no se tiene q completar, se puede ingresar los primeros carateres noma)

### Install images to instance

docker pull hello-world
docker pull nginx:alpine
docker pull ubuntu
b
### Run image

docker run <image name/>
ej: docker run hello-world
ej: docker run -d -p 8080:80 nginx:alpine

> la imagen corre en el puerto 8080 pero se muestra en el 80

#### Run ubuntu

docker run -it ubuntu bash

> Corre la imagen de ubuntu e iteractua con el (-it), abriendo el bash

##### Comandos ubuntu

apt-get update
(actualizar imagen)

ls -l
(listar archivos dentro la imagen)

apt-get install figlet
figlet "Hola"
(instala la applicacion 'figlet' que muestra texto en letras grandes, en consola)

### Nose aun que hacen

docker commit <image id/>

docker image tag <image id/>

### Virtual box

service docker start
