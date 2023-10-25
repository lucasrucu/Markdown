# Wildfly

## Correr Wildfly

Abrir carpeta bin en `cmd` y escribir comando `domain`.

Para ingresar al Wildfly ingresar al navegador `127.0.0.1:9990`

Esto abre una ventana donde te pide credenciales que son:

> Nombre de usuario: admin
> Contraseña: Passw0rd

## Arquitectura de Wildfly

La capa base es del sistema operativo (OS)
Encima de ello se encuentra el JDK
Y encima del JDK esta el Wildfly.
Encima del Wildfly (en el ejemplo que estamos viendo), existen 3 maquinas virtuales JVM (java virtual machines).

![Wildfly architecture](/Assets/Images/diagram_wildfly_architecture.png)

## Que hace?

Vemos en clase como con boomerang (maneja pedidos http), como este envía a las distintas maquinas virtuales pedidos http y en Wildfly, que tiene un balanceador, este maneja las conexiones y envía los pedidos al servidor disponible.