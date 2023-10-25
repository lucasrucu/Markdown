## Open Source SQL

### Indice

- [Open Source SQL](#open-source-sql)
  - [Indice](#indice)
  - [Crear Archvio](#crear-archvio)
  - [Crear Carpetas](#crear-carpetas)
  - [Crear Clases e Interfaces](#crear-clases-e-interfaces)
    - [Model](#model)
    - [Repository](#repository)
    - [Service](#service)
      - [Service Interface](#service-interface)
      - [Service Impl](#service-impl)
    - [Exception](#exception)
      - [ControllerExceptionHandler](#controllerexceptionhandler)
      - [ErrorMessage](#errormessage)
      - [ResourceNotFoundException](#resourcenotfoundexception)
      - [ValidationException](#validationexception)
    - [Controller](#controller)
    - [Application Properties](#application-properties)
    - [Dependencias](#dependencias)
    - [Swagger](#swagger)
    - [Security](#security)
    - [Cors](#cors)
    - [Mapper](#mapper)

### Crear Archvio

Ingresar a [Spring Framework](https://start.spring.io/) y usar las siguientes configuraciones:

- Maven
- Spring boot 3.1.0
- Java 20 `Recomiendo usar el 17`
- Dependencias:
  - Lombok
  - Spring Web
  - Sprinf Data JPA
  - MySQL Driver
- Abrir en IntelliJ

> Tambien puedes descargar un proyecto de ejemplo desde [aqui](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.1.1&packaging=jar&jvmVersion=20&groupId=com.upc&artifactId=demo&name=demo&description=Demo%20project%20for%20Spring%20Boot&packageName=com.upc.demo&dependencies=lombok,web,data-jpa,mysql,security,postgresql)
> Una vez descargado, descomprimir y abrir en IntelliJ
>
> > El proyecto tiene las mismas dependencias que se mencionaron anteriormente y tiene de nombre demo y grupo com.upc

### Crear Carpetas

Dentro de su proyecto crear la siguiente estructura de carpetas

- config
- controller
- dto
- exception
- model
- repository
- service
  - impl

### Crear Clases e Interfaces

#### Model

Nombre a utilizar:

> _Account_ o _Transaction_

Codigo ejemplo:

```java
package com.upc.Ejercicio.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "loans")
public class Loan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "code_student", nullable = false, length = 10)
    private String codeStudent;

    @Column(name = "loan_date", nullable = false)
    private LocalDate loanDate;

    @Column(name = "devolution_date", nullable = false)
    private LocalDate devolutionDate;

    @Column(name = "book_loan", nullable = false)
    private boolean bookLoan;

    @ManyToOne
    @JoinColumn(name = "book_id", nullable = false,
    foreignKey = @ForeignKey(name = "FK_BOOK_ID"))
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private Book book;
}
```

> El valor de _name_ en la anotacion _@Table_ sera el nombre de la tabla en la base de datos, y en _@Column_ sera el nombre de la columna en la base de datos.

#### Repository

Nombre a utilizar:

> _AccountRepository_ o _TransactionRepository_

Codigo ejemplo:

```java
package com.upc.Ejercicio.repository;

import com.upc.Ejercicio.model.Book;
import com.upc.Ejercicio.model.Loan;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LoanRepository extends JpaRepository<Loan, Long> {
    boolean existsByCodeStudent(String codeStudent);
    boolean existsByCodeStudentAndBookAndBookLoan(String codeStudent, Book book, boolean bookLoan);
    List<Loan> findByCodeStudent(String codeStudent);
    List<Loan> findByCreateDateBetween (String startDate, String endDate);
}
```

> Los metodos aqui te sirven para filtar los datos u obtener informacion que te sirva despues en el controller. Esto se puede conseguir siguiendo una estructura simial a una query de MySQL o incluso puedes agregar tu propia query con `@Query`

> Los repositorios extienden de JpaRepository, el cual tiene metodos como _save_, _findAll_, _deleteById_, etc. Para mas informacion puedes ingresar a [JpaRepository](https://docs.spring.io/spring-data/jpa/docs/current/api/org/springframework/data/jpa/repository/JpaRepository.html)

#### Service

Se van a crear dos archivos, uno fuera del directorio _impl_ y otro dentro.
Los archivos interface tendran los metodos para realizar CRUD y cualquier otro metodo que se halla implementado en el repositorio, mientras que los archivos impl tendran la implementacion de los metodos.
Se tendran los siguientes nombres:

> _AccountService_ o _TransactionService_

> _AccountServiceImpl_ o _TransactionServiceImpl_

Codigo ejemplo:

##### Service Interface

```java
package com.upc.Ejercicio.service;

import com.upc.Ejercicio.model.Book;

public interface BookService {
    public abstract Book creat(Book book);
    public abstract Book getById(Long book_id);
    public abstract List<Book> getAll();
    public abstract Book update(User book);
    public abstract void delete(Long book_id);
    public abstract List<Transaction> getByCreateDateBetween(String startDate, String endDate);
    public abstract boolean existsByAmountAndBalance(double amount, double balance);
}
```

> Estan los metodos CRUD y tambien los metodos que se implementaron dentro del repositorio

##### Service Impl

```java
import com.upc.OpenSourceEjercicio3.exception.ValidationException;
import com.upc.OpenSourceEjercicio3.model.Transaction;
import com.upc.OpenSourceEjercicio3.repository.TransactionRepository;
import com.upc.OpenSourceEjercicio3.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class TransactionServiceImpl  implements TransactionService {
    @Autowired
    private TransactionRepository transactionRepository;

    @Override
    public Transaction create(Transaction transaction) {
        transaction.setCreateDate(LocalDate.now());
        if (transaction.getType().equals("Retiro")){
            transaction.setBalance(transaction.getBalance()-transaction.getAmount());
        }
        else {
            transaction.setBalance(transaction.getBalance()+transaction.getAmount());
        }
        validateTransaction(transaction);
        return transactionRepository.save(transaction);
    }

    @Override
    public Transaction getById(Long transaction_id) {
        return transactionRepository.getByTransactionId(transaction_id);
    }

    @Override
    public List<Transaction> getAll() {
        return transactionRepository.findAll();
    }

    @Override
    public Transaction update(Transaction transaction) {
        return transactionRepository.save(transaction);
    }

    @Override
    public void delete(Long transaction_id) {
        transactionRepository.deleteById(transaction_id);
    }

    @Override
    public List<Transaction> getByAccountNameCustomer(String nameCustomer) {
        return transactionRepository.getByAccount_NameCustomer(nameCustomer);
    }

    @Override
    public List<Transaction> getByCreateDateBetween(LocalDate startDate, LocalDate endDate) {
        return transactionRepository.getByCreateDateBetween(startDate, endDate);
    }

    private void validateTransaction(Transaction transaction){
        if (transaction.getType() == null || transaction.getType().isEmpty()){
            throw new ValidationException("El tipo de transacción bancaria debe ser obligatorio");
        }
        if (!(transaction.getType().equals("Retiro")) && !(transaction.getType().equals("Deposito"))){
            throw new ValidationException("El tipo de transacción bancaria debe ser Retiro o Deposito");
        }
        if (transaction.getAmount()<=0){
            throw new ValidationException("El monto en una transacción bancaria debe ser mayor de S/.0.0");
        }
        if (transaction.getAmount()>transaction.getBalance()){
            throw new ValidationException("En una transacción bancaria tipo retiro el monto no puede ser mayor al saldo");
        }
    }
}
```

> En la implementacion van los metodos CRUD como `@Override` y los metodos que se crearon en el repositorio. De este modo la interaccion con la base de datos y el controller pasa siempre por el servicio.

> Tomar en cuenta que las reglas de negocio, validaciones y cualquier otro cambio necesario se realiza aqui.

#### Exception

Se van a crear 4 archivos con los siguientes nombres:

> ControllerExceptionHandler
> ErrorMessage
> ResourceNotFoundException
> ValidationException

Codigo ejemplo:

##### ControllerExceptionHandler

```java
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.time.LocalDateTime;

@RestControllerAdvice
public class ControllerExceptionHandler {
    @ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    public ErrorMessage resourceNotFoundException(ResourceNotFoundException ex, WebRequest request) {
        ErrorMessage message = new ErrorMessage(
                HttpStatus.NOT_FOUND.value(),
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return message;
    }

    @ExceptionHandler(ValidationException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public ErrorMessage validationException(ValidationException ex, WebRequest request) {
        ErrorMessage message = new ErrorMessage(
                HttpStatus.BAD_REQUEST.value(),
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return message;
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorMessage globalExceptionHandler(Exception ex, WebRequest request) {
        ErrorMessage message = new ErrorMessage(
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return message;
    }
}
```

##### ErrorMessage

```java
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ErrorMessage {
    private int statusCode;
    private String message;
    private String description;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy hh:mm:ss")
    private LocalDateTime timestamp;
}
```

##### ResourceNotFoundException

```java
public class ResourceNotFoundException extends RuntimeException{
    public ResourceNotFoundException() {
        super();
    }

    public ResourceNotFoundException(String message) {
        super(message);
    }
}
```

##### ValidationException

```java
public class ValidationException extends RuntimeException {
    public ValidationException() {
        super();
    }

    public ValidationException(String message) {
        super(message);
    }
}
```

#### Controller

En el controller se hara uso de los verbos HTTP GET, POST, PUT y DELETE.
El nombre del archivo sera:

> *modelName*Controller

Codigo ejemplo:

```java
import com.upc.OpenSourceEjercicio3.model.Transaction;
import com.upc.OpenSourceEjercicio3.service.AccountService;
import com.upc.OpenSourceEjercicio3.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/bank/v1")
public class TransactionController {
    @Autowired
    private TransactionService transactionService;

    @Autowired
    private AccountService accountService;

    public TransactionController() {
    }

    // URL: http://localhost:8080/api/bank/v1/transactions/filterByNameCustomer
    // Method: GET
    @Transactional
    @RequestMapping("/transactions/filterByNameCustomer")
    public ResponseEntity<List<Transaction>> filterByNameCustomer(@RequestParam(name = "nameCustomer") String nameCustomer) {
        return new ResponseEntity<List<Transaction>>(transactionService.getByAccountNameCustomer(nameCustomer), HttpStatus.OK);
    }

    // URL: http://localhost:8080/api/bank/v1/transactions/filterByCreateDateRange
    // Method: GET
    @Transactional
    @RequestMapping("/transactions/filterByCreateDateRange")
    public ResponseEntity<List<Transaction>> filterByCreateDateRange(@RequestParam(name = "startDate") LocalDate startDate, @RequestParam(name = "endDate") LocalDate endDate) {
        return new ResponseEntity<List<Transaction>>(transactionService.getByCreateDateBetween(startDate, endDate), HttpStatus.OK);
    }

    // URL: http://localhost:8080/api/bank/v1/accounts/{id}/transactions
    // Method: POST
    @Transactional
    @RequestMapping("/accounts/{id}/transactions")
    public ResponseEntity<Transaction> createTransaction(@PathVariable(value = "id") Long accountId, @RequestBody Transaction transaction) {
        return new ResponseEntity<Transaction>(transactionService.create(transaction), HttpStatus.CREATED);
    }
}

```

#### Application Properties

Ahora se hara la conexion con la base de datos. Antes de realizar el codigo se debe ingresar a **MySQL Workbench** y crear una base datos. Una vez creado, se debe modificar el archivo _application.properties_ con el siguiente codigo:

```properties
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/db_backend?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=1234
spring.jpa.hibernate.ddl-auto=update

server.port=8090
springdoc.swagger-ui.path=/swagger-ui.html
```

Lo que debes modificar es en el link db_backend por el nombre de tu base de datos y en el password por el que tengas.

> **Nota:** Si no tienes MySQL Workbench, puedes descargarlo desde [aqui](https://dev.mysql.com/downloads/workbench/)

#### Dependencias

```xml
<dependencies>
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-data-jpa</artifactId>
	</dependency>
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-web</artifactId>
	</dependency>
	<dependency>
		<groupId>com.mysql</groupId>
		<artifactId>mysql-connector-j</artifactId>
		<scope>runtime</scope>
	</dependency>
	<dependency>
		<groupId>org.postgresql</groupId>
		<artifactId>postgresql</artifactId>
		<scope>runtime</scope>
	</dependency>
	<dependency>
		<groupId>org.projectlombok</groupId>
		<artifactId>lombok</artifactId>
		<optional>true</optional>
	</dependency>
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-test</artifactId>
		<scope>test</scope>
	</dependency>
</dependencies>
```

#### Swagger

Si implemento el codigo anterior con las dependencias y la configuracion en el _application.properties_, al ejecutar el proyecto y entrar a la siguiente URL:

> http://localhost:8080/swagger-ui/index.html

Se mostrara la documentacion de los servicios que se crearon.

```xml
<dependency>
	<groupId>org.springdoc</groupId>
	<artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
	<version>2.1.0</version>
</dependency>
```

#### Security

Se instala la siguiente dependencia y se agrega la configuracion en el application.properties

```xml
<dependency>
	<groupId>org.springframework.security</groupId>
	<artifactId>spring-security-test</artifactId>
	<scope>test</scope>
</dependency>
```

```properties
spring.security.user.name=admin
spring.security.user.password=admin
```

#### Cors

Crear una carpeta con nombre config y dentro un archivo con nombre CorsConfig

```java
@Configuration
public class CorsConfig{

    @Bean
    public WebMvcConfigurer corsConfigurer(){
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/*")
                        .allowedOrigins("http://localhost:4200")
                        .allowedMethods("*")
                        .allowedHeaders("*");

            }
        };
    }

}


```

#### Mapper

En el archivo pom.xml actualizas las dependencias y agregas la siguiente dependencia:

```xml
<dependency>
	<groupId>org.modelmapper</groupId>
	<artifactId>modelmapper</artifactId>
	<version>2.4.4</version>
</dependency>
```

En el archivo de tu application tambien debes agregar lo siguiente:

```java
@SpringBootApplication
public class EcodriveApplication {

	@Bean
	public ModelMapper modelMapper() {
		return new ModelMapper();
	}

	public static void main(String[] args) {
		SpringApplication.run(EcodriveApplication.class, args);
	}

}
```

Creas el modelo al que deseas mappear dentro de una carpeta nueva llamada `dto`, y al archivo le pones el nombre de la entidad a la que deseas mapearle.

> Ejemplo: UserDto

```java
import lombok.Data;

@Data
public class Response {
    private Long driverId;
    private Float value;
}
```

Y esto lo puedes implementar dentro de tu servicio de la siguiente manera:

```java
@Override
public Response getScoreScope(Long driverId, Integer scope) {
    validateScope(scope);
    existsDriver(driverId);
    Score score = new Score();
    score.setDriverId(driverId);
    if (scope == 0) {
        score.setValue(scoreRepository.findAverageScoreByDriverI(driverId));
    } else {
        score.setValue(scoreRepository.findMaxScoreByDriverI(driverId));
    }
    return modelMapper.map(score, Response.class);
}
```

La ultima linea solo realiza el mapeo, pero recuerda que debes inicializar el modelMapper en el constructor de tu servicio.
Una ultima cosa, es caso tu mapeo incluye alguna relacion de 1 a muchos y no se muestra aquella lista, en el mismo metodo donde realizas el mapeo debes agregar lo siguiente:

```java
@Override
public Response getScoreScope(Long driverId, Integer scope) {
    modelMapper.getConfiguration().setMatchingStrateg(MatchingStrategies.LOOSE);
    validateScope(scope);
    existsDriver(driverId);
    Score score = new Score();
    score.setDriverId(driverId);
    if (scope == 0) {
        score.setValue(scoreRepository.findAverageScoreByDriverI(driverId));
    } else {
        score.setValue(scoreRepository.findMaxScoreByDriverI(driverId));
    }
    return modelMapper.map(score, Response.class);
}
```

---

[Regresar al inicio](#indice)

//002
