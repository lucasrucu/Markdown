# Laboratorio Semana 12

## Objetivo

Conectar las aplicaciones de Wildfly a una base de datos mysql.

## Configuración

Empieza ejecutando Wildfly, seguir los pasos [aquí](Fundamentos%20-%20Wildfly.md).
Seguir los siguientes pasos después:

1. Configuration > Profiles > ha
2. Datasource & Drivers > JDBC Drivers
   Se deberían encontrar 2 drivers, h2 & oracle
3. Ingresar a la carpeta de Wildfly, ingrese a: modules > system > layers > base > com
   Aqui se encuentran los drivers para distintas DB. En esta caso si ingresan a uno pueden encontrar la carpet de main, y dos archivo, un xml y jar
4. Copiar driver de mysql a la carpeta `com`
   La carpeta de mysql debe seguir la misma estructura como el resto, la carpeta main, y dentro los dos archivos
5. Levanta el servidor, Wildfly, de nuevo
6. Ingresar de nuevo al apartado `JDBC Drivers`, y agregue un driver con las siguientes características:

> Driver name: mysql
> Driver Module Name: com.mysql
> Driver class name: com.mysql.cj.jdbc.Driver
> Driver XA Datasource class name: com.mysql.cj.jdbc.MysqlXADataSource


7. Ahora en la maquina se  deberá configurar y conectar el DB
8. Entrar a Workbench e ingresar a la conexión local.

> Password: 12345678

9. Ahora de regreso en el Wildfly, ingresamos en ves de JDBC Drivers, ingresamos a `Datasource`
10. Agregar un Datasource normal
	1. Choose template: MySQL
	2. Attributes: leave default
	3. JDBC Driver: leave default
	4. Connection:
	   - Connection URL: termina en el nombre de tu DB
	   - Username: root
	   - Password: 12345678
	5. Probar la conexión y finalizar.
11. Ingresar a Eclipse *Neon* y crear un nuevo proyecto
12. File > New Project > Web > Dynamic Web Project
13. Pasos de la configuración que no me acuerdo...
14. Convertir el proyecto para usar maven
15. Agregar las dependencias que paso el profesor
16. Agregar tres archivos JSP a la carpeta WebContent
17. Ya vole 🛫


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