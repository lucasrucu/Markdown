# Microservice with Spring Boot

## Setup Spring Boot project
### Create the project

[initlzr](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.1.5&packaging=jar&jvmVersion=1.8&groupId=upc.edu&artifactId=consultas&name=consultas&description=Demo%20project%20for%20Spring%20Boot&packageName=upc.edu.consultas&dependencies=web)

### Add `Swagger` 

add the dependency to `pom.xml`

```xml
	<dependencies>
		<dependency>
			<groupId>org.springdoc</groupId>
			<artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
			<version>2.2.0</version>
		</dependency>
	</dependencies>
```

## Domain (models)
### Understand the .json files

This is the input for Consulta
Consulta
```json
{
   "CodigoProducto": "001",
   "TipoConsulta": "1",
   "IdConsulta": "10147170"
}
```


This is the output
Consulta Response
```json
{
"Producto":"Hotel",
"Nombre":"Marriot",
"desde":"06/11/2023",
"hasta":"10/11/2023"
}
```


Create `domain` package and inside `Consulta.java` and `ConsultaResponse.java`

```java
public class Consulta {
    public String CodigoProducto;
    public String TipoConsulta;
    public String IdConsulta;
}
```


```java
public class ConsultaResponse {
	public String Producto;
	public String Nombre;
	public String desde;
	public String hasta;
}


## ApiRest `controller`

Create `controller` package and `ConsultaController.java`

java
@RestController
@RequestMapping("/api/v1/consultas")
public class ConsultaController {

    @Transactional
    @PostMapping("")
    public ResponseEntity<ConsultaResponse> createConsulta(Consulta consulta) {
        ConsultaResponse consultaResponse = new ConsultaResponse();
        consultaResponse.Producto = "Example Product";
        consultaResponse.Nombre = "Example Name";
        consultaResponse.desde = "Example Desde";
        consultaResponse.hasta = "Example Hasta";
        return ResponseEntity.ok(consultaResponse);
    }
}
```

Link to the doc API (swagger): http://localhost:8080/swagger-ui/index.html