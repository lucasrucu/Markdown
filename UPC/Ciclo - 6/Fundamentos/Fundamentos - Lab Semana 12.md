# Laboratorio Semana 12

## Objetivo

Conectar las aplicaciones de Wildfly a una base de datos mysql.

## Configuración

Empieza ejecutando Wildfly, seguir los pasos [aquí](Fundamentos%20-%20Wildfly.md).
Seguir los siguientes pasos después:

1. Configuration > Profiles > ha
2. Datasource & Drivers > JDBC Drivers
   Se deberían encontrar 2 drivers, h2 & oracle

---
## Notas

- Hay en el Wildfly 2 aplicaciones y un server balancer
- El driver se va a configurar en ha
- Los servidores, que son las aplicaciones, son tipo ha
- En modo standalone hay 1 solo servidor
- ha = high availability
- Para convertir objetos (de la app) hacia registros (del DB), se usa una capa de persistencia
- Persistencia = todo lo que uno hace para que la data no se pierda (Driver BD, OLEDB, JDBC, ODBC, XA)
- Driver, es un programa, la capa de persistencia, convierte objetos a registros y registros a objetos. El driver permite conectar a todos los DB de un tipo (i.e. mysql)