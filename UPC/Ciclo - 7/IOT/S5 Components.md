# IoT Components
Una solución IoT completa tiene cuatro distintos componentes:

## Sensors/devices
Lo sensores y dispositivos recolectan datos de su entorno, como por ejemplo leer la temperatura. Se pueden conbinar múltiples sensores.
Por ejemplo, un smartphone es un dispositivo, tiene múltiples sensores (cámara, acelerómetro, GPS, etc.), es decir no solo es un sensor.

## Connectivity
Los sensors/devices se pueden conectar a la nube a través de una variedad de métodos incluyendo: celular, satélite, WiFi, Bluetooth, low-power wide-are networks (LPWAN), o en algunos casos conectarse directamente a internet vía ethernet.

## User interface
Presentar la información útil de alguna forma al usuario.
Podría ser vía email, texto, notificaciones, entre otros. Ejemplo: Alerta como texto cuando la temperatura es muy alta en la cámara frigorífica del almacén.
También, el usuario debería tener un interfaze que permita la verificación proactiva. Por ejemplo, un usuario podría querer revisar los videos de las cámaras de su casa vía una aplicación móvil o un web browser.
Realizar acciones con la información, el usuario podría tener la opción de interactura con que tenga un efecto en la solución. O, podría realizarse esta acción de forma automática. Por ejemplo, cuando la temperatura es alta bajarla de forma automática.

## Connectivity & Latency
Latencia se refiere a cuánto tiempo toma a un paquete de datos ir del punto de origen al punto destino.
Aunque en muchos casos la latencia podría no ser tan importante, en otros es crítico.

## Connectivity & Gateways
En vez de enviar los datos a través de una red para se procesen en la nube, un approach alternativo es procesar los datos en un gateway o en el propio sensor/device. esto se conoce como *fog computing* o *edge computing*.