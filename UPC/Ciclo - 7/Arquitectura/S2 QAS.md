---
tags:
  - "#arquitecture"
  - qas
---
Artefacto: componentes que recibe estimulo
Componentes: un modulo intercambiable (un modulo es uno o un conjunto de clases)

El modulo puede trabajar con otros gracias a interfaces.

Ejemplos: El usuario podrá consultar el catalogo de productos del sistema, en un horario de operación normal, obteniendo el resultado en un tiempo máximo de 3 segundos.
	Atributo: desempeño 
	Fuete: usuario
	Estimulo: consulta de catalogo de productos
	Artefacto: sistema
	Entorno: operación normal
	Respuesta: resultado de la consulta
	Medida: T<=3s

|Atributo|Fuente|Estimulo|Artefacto|Entorno|Respuesta|Medida|
|:----|:----|:----|:----|:----|:----|:----|
|Fiabilidad|Viajero|Entrar a la plataforma web en cualquier hora del día|Frontend|Plataforma web accedida por el usuario a cualquier hora del día|Logra cargarse el portal web en el dispositivo del usuario a cualquier hora del día|Numero de visitas registradas a cualquier hora del día|
|Usabilidad|Viajero|Reserva un paquete de viaje en menos de 10 minutos|Frontend y backend|Servidores Frontend y backend procesando el proceso de reserva de paquetes de viaje|Logran realizar la reserva|Tiempo en realizar la reserva desde que el usuario ingresa a la pagina|
|Rendimiento|Agencia de viaje|Solicitud de procesar transacciones de pagos de paquetes de viaje|Frontend y backend|Carga de 500 transacciones de pagos de paquetes de viaje, sin tiempos de espera para los usuarios o menor a 1 segundo|Logra procesarse con satisfacción las transacciones de pagos de paquetes de viaje|Número de solicitudes de pagos de viaje no mayores a 500 transacciones por hora|
|Seguridad|Usuarios|Solicitud de autenticación y autorización menor a 2 segundos|Backend|Servidores backend procesando la autenticación y autorización|Logran autenticarse y autorizar a los usuarios|Tiempo de respuesta de la solicitud en los servidores|


![](../../../Assets/Images/Pasted%20image%2020240412180555.png)

Raje del sistema de seguridad del gobierno
- Caso donde INDECOPI fue hackeado
- El año pasado hackearon y sacaron a la luz planes en caso se daba guerra con chile
- Hace 4 meses hackearon el británico. Intentaron usar un backup, pero el encargado no lo había hecho desde hace 3 meses, por ello lo despidieron, pues se tenia que hacer a diario, y realizaron las ultimas transacciones y lo agregaron a mano.

QAS es una tabla que permite identificar los elementos importantes o también los quality atribute workshop.

Una TACTICA es una decision de diseño para cuando el atributo de calidad se realize, entonces con este se podrá asegurar su cumplimiento.
Ej:
- Realizar ping a un servidor. En caso no este resultando, entonces realizar alguna acción.
- Beat. Cuando un beat no llega, entonces hay un problema con el servicio, en este caso si no llega un beat entonces se estima que el servicio cayo.

En linea: se atienden en el momento (depende si es sincrónico o asincrónico)
En bach: procesan grandes cantidades de solicitud 100k a 1m, se procesa en forma secuencia, se ejecutan en la noche (hora en la que ya no hay clientes), mayoría de clientes tienen al menos 1 proceso bach [un backup de servidores]

Meta data en una tarjeta: en sistemas antiguos, por temas de business inteligence, pasan tu tarjeta en el POS y también por una ranura. El de la ranura, no es necesario, este solo captura metadata de quien es banco emisor, blablabla.