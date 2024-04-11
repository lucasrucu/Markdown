## Crear Spring Project

Go the following link [Spring](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.2.4&packaging=jar&jvmVersion=17&groupId=pe.edu.upc&artifactId=test&name=test&description=Demo%20project%20for%20Spring%20Boot&packageName=pe.edu.upc.test) and download the project if need be. The configuration for this link are

- Maven
- Java
- 3.2.4
- Jar
- Java 17

Extrae el archivo donde prefieras.

## Git Upload

``` bash
git init
```

``` bash
git add .
```

``` bash
git commit -m "First Commit"
```

## Folder Structure

Al mismo nivel donde extrajiste el archivo, ahora agrega un carpeta con el prefijo de wsk seguido por un guion y el nombre de tu proyecto. Ejemplo: *wsk_test*.

## Launch STS

Al lanzar el programa de STS, seras incitado a escoger un workspace. Para esto se creo la carpeta wsk. Escoje la carpeta, y una vez realizado esto, se podra visualizar dentro la carpeta el meta data que crea el IDE.

### Change Java SDK

Dentro del IDE, ingresa a:

- Window
- Preferences
- Java
- Installed JREs

Una vez alli, presione el boton de agregar, next, y busca el archivo de Java 17.

> Normalmente esta en la carpeta de Program Files, y despues dentro de Java

El nombre de la carpeta deberia ser algo como `Java 17`.

Una vez encontrado y selecionado, presione el ok, y cuando la venta cierre, presione al check que esta al costado del nombre.
Presione `Apply and Close` para terminar.

### Import Project

En la ventana de la izquierda deberia estar abierto la opcion para poder importar el proyecto, presionalo, escoge dentro la carpeta `Maven` la ocion de `Existing Maven Project`.
Escoge entonces la carpeta al costado del wsk previamente escogido, y abrela.

### Crear Clase

- Click derecho en el package dentro de la carpeta src/main/java
- Seleccionar `New` y despues `Class`
- Agregar nombre
- Presionar `Finish`

Codigo ejemplo

``` java
public boolean isPalindrome(String inputString) {

if (inputString.length() == 0) {

return true;

} else {

char firstChar = inputString.charAt(0);

char lastChar = inputString.charAt(inputString.length() - 1);

String mid = inputString.substring(1, inputString.length() - 1);

return (firstChar == lastChar) && isPalindrome(mid);

}

}
```

### Crear Test

- Click derecho a la clase
- Escoger `New ` y despues `JUnit Test`
- No cambiar nada y presionar finish