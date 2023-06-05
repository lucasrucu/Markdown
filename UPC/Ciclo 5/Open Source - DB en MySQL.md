## Open Source SQL

### Indice

1. [Crear Archivo](#crear-archivo)
2. [Crear Carpetas](#crear-carpetas)
3. [Crear Clases e Interfaces](#crear-clases-e-interfaces)

   3.1. [Model](#model)

   3.2. [Repository](#repository)

   3.3. [Service](#service)

   3.4. [Exception](#exception)

   3.5. [Controller](#controller)

   3.6. [Application Properties](#application-properties)

### Crear Archvio

Ingresar a [Spring Framework](https://start.spring.io/) y usar las siguientes configuraciones:

- Maven
- Spring boot 3.1.0
- Java 20
- Dependencias:
  - Lombok
  - Spring Web
  - Sprinf Data JPA
  - MySQL Driver
- Abrir en IntelliJ

> Tambien puedes descargar un proyecto de ejemplo desde [aqui](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.1.0&packaging=jar&jvmVersion=20&groupId=com.upc&artifactId=demo&name=demo&description=Demo%20project%20for%20Spring%20Boot&packageName=com.upc.demo&dependencies=lombok,web,data-jpa,mysql)
> Una vez descargado, descomprimir y abrir en IntelliJ
>
> > El proyecto tiene las mismas dependencias que se mencionaron anteriormente y tiene de nombre demo y grupo com.upc

### Crear Carpetas

Dentro de su proyecto crear la siguiente estructura de carpetas

- controller
- exception
- model
- repository
- service
  - impl

### Crear Clases e Interfaces

#### Model

Nombre a utilizar:

> _modelName_

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

#### Repository

Nombre a utilizar:

> *modelName*Repository

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
}
```

#### Service

Se van a crear dos archivos, uno fuera del directorio _impl_ y otro dentro.
Se tendran los siguientes nombres:

> *modelName*Service
> *modelName*ServiceImpl

Codigo ejemplo:

##### Service Interface

```java
package com.upc.Ejercicio.service;

import com.upc.Ejercicio.model.Book;

public interface BookService {
    public abstract Book createBook(Book book);
}
```

##### Service Impl

```java
package com.upc.Ejercicio.service.impl;

import com.upc.Ejercicio.model.Book;
import com.upc.Ejercicio.repository.BookRepository;
import com.upc.Ejercicio.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    private BookRepository bookRepository;

    @Override
    public Book createBook(Book book) {
        return bookRepository.save(book);
    }
}
```

#### Exception

Se van a crear 4 archivos con los siguientes nombres:

> ControllerExceptionHandler
> ErrorMessage
> ResourceNotFoundException
> ValidationException

Codigo ejemplo:

##### ControllerExceptionHandler

```java
package com.upc.Ejercicio.exception;

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
package com.upc.Ejercicio.exception;

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
package com.upc.Ejercicio.exception;

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
package com.upc.Ejercicio.exception;

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
package com.upc.Ejercicio.controller;

import com.upc.Ejercicio.exception.ValidationException;
import com.upc.Ejercicio.model.Book;
import com.upc.Ejercicio.repository.BookRepository;
import com.upc.Ejercicio.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/library/v1")
public class BookController {
    @Autowired
    private BookService bookService;

    private final BookRepository bookRepository;

    public BookController(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    // URL: http://localhost:8080/api/library/v1/books
    // Method: GET
    @Transactional(readOnly = true)
    @GetMapping("/books")
    public ResponseEntity<List<Book>> getAllBooks() {
        return new ResponseEntity<List<Book>>(bookRepository.findAll(), HttpStatus.OK);
    }

    // URL: http://localhost:8080/api/library/v1/books/filterByEditorial
    // Method: GET
    @Transactional(readOnly = true)
    @GetMapping("/books/filterByEditorial")
    public ResponseEntity<List<Book>> getAllBooksByEditorial(@RequestParam(name = "editorial") String editorial) {
        return new ResponseEntity<List<Book>>(bookRepository.findByEditorial(editorial), HttpStatus.OK);
    }

    // URL: http://localhost:8080/api/library/v1/books
    // Method: POST
    @Transactional
    @PostMapping("/books")
    public ResponseEntity<Book> createBook(@RequestParam(name = "book") Book book) {
        return new ResponseEntity<Book>(bookService.createBook(book), HttpStatus.CREATED);
    }

    private void validateBook(Book book) {
        if (book.getTitle() == null || book.getTitle().isEmpty()) {
            throw new ValidationException("El título del libro debe ser obligatorio");
        }
        if (book.getTitle().length() > 22) {
            throw new ValidationException("El título del libro no debe exceder los 22 caracteres");
        }
        if (book.getEditorial() == null || book.getEditorial().isEmpty()) {
            throw new ValidationException("La editorial del libro debe ser obligatorio");
        }
        if (book.getEditorial().length() > 14) {
            throw new ValidationException("La editorial del libro no debe exceder los 14 caracteres");
        }
    }

    private void existsBookByTitleAndEditorial (Book book) {
        if (bookRepository.existsByTitleAndEditorial(book.getTitle(), book.getEditorial())) {
            throw new ValidationException("No se puede registrar el libro porque existe uno con el mismo titulo y editorial");
        }
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
```

Lo que debes modificar es en el link db_backend por el nombre de tu base de datos y en el password por el que tengas.

> **Nota:** Si no tienes MySQL Workbench, puedes descargarlo desde [aqui](https://dev.mysql.com/downloads/workbench/)

---

[Regresar al inicio](#indice)

//002
