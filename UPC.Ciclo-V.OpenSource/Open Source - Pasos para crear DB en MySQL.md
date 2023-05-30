## Open Source SQL

---

### Crear Archvio

Ingresar a [Spring Framework](start.spring.io) y usar las siguientes configuraciones:

- Maven
- Spring boot 3.1.0
- Java 20
- Dependencias:
  - Lombok
  - Spring Web
  - Sprinf Data JPA
  - MySQL Driver
- Abrir en IntelliJ

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

```
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

```
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

##### Service

```
package com.upc.Ejercicio.service;

import com.upc.Ejercicio.model.Book;

public interface BookService {
    public abstract Book createBook(Book book);
}
```

##### Service Impl

```
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

```
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

```
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

```
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

```
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
