## Crear Proyecto

1. New
2. Other
3. Dynamic web Project
4. Project Name: appPc2
5. next
6. next
7. Generate XML: check
8. finish

## Convertir a Maven

1. Click derecho
2. Convertir a Maven
3. Colocar mismo nombre del proyecto en el campo `NAME`
4. Finish

## Agregar Dependencias

1. Click derecho en el archivo pom
2. Escoger editar como texto
3. Agregar las dependencias

```xml
<dependencies>
	  <dependency>
			<groupId>javax</groupId>
			<artifactId>javaee-api</artifactId>
			<version>7.0</version>
			<scope>provided</scope>
			<type>jar</type>
		</dependency>
		<dependency>
			<groupId>org.wildfly.core</groupId>
			<artifactId>wildfly-server</artifactId>
			<version>2.2.0.Final</version>
			<scope>provided</scope>
		</dependency>
  </dependencies>
```

## ???

1. Crear paquetes
2. Nombre: api, api.domain, api.service

## API Domain

1. Click derecho
2. Crear una clase nueva
3. Nombre: consulta
4. Codigo:
```

```

## Export

1. Click derecho
2. Export
3. War
