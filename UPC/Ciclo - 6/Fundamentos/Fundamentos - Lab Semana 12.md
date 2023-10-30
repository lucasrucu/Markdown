# Laboratorio Semana 12

## Objetivo

Conectar las aplicaciones de Wildfly a una base de datos mysql.

## Configuración

Empieza ejecutando Wildfly, seguir los pasos [aquí](Fundamentos%20-%20Wildfly.md).
Seguir los siguientes pasos después:

1. Configuration > Profiles > ha 

---
## Notas

- Hay en el Wildfly 2 aplicaciones y un server balancer.
- El driver se va a configurar en ha.
- Los servidores, que son las aplicaciones, son tipo ha.
- En modo standalone hay 1 solo servidor.
- ha = high availability