NAT: si dentro de una red tiene una computador virtual, este usara la dirección del computador físico.

Puente Adaptador: permite que la computadora virtual tenga su propia dirección IP, permitiendo o mostrando que la computadora virtual en verdad fuera independiente.

## Instalación del laboratorio

En la clase se realizo la instalación de ubuntu, un SDK y también un Wildfly.

1. Se crea la maquina virtual en [VirtualBox](https://www.virtualbox.org/).
2. ... algunos pasos que quizá me saltee 👉👈
3. Configuración del ubuntu:
	1. Escoger el idioma de ingles
	2. Escoger configuración del teclado: a criterio propio
	3. Escoger el tipo de ubuntu: **Ubuntu Server**
	4. Editar el eth -> Edit IPv4:
		1. Subnet: 10.11.38.0/23
		2. Address: 10.11.38.89
		3. Gateway: 10.11.36.1
		4. Name servers: 8.8.8.8
		5. Search domain: upc.pe
		6. Guardar (save)
	5. Proxy: none
	6. Use entire disk: yes
	7. Profile:
		1. Your name: admin
		2. Server name: server1
		3. username: lucas
		4. password: 12345678
	8. SSH: yes
	9. to be continued ...
