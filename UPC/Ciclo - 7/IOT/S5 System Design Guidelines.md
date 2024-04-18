# IoT System Design Guidelines

## System general architecture

### Physical layer
La capa física está compuesta por nodos sensores y actuadores. que permiten el seguimiento y control de magnitudes físicas relacionados con los objetos físicos.
### Data Exchange Layer
Tiene como objetivo proporcionar capacidades de conexión a Internet a los nodos sensores y actuadores. En particular, los datos se recopilan de los nodos sensores y se comparten a través de Internet. Se pueden enviar comandos a los actuadores.
### Information integration layer
La capa de integración de información también se conoce como capa de middleware. Almacena, analiza y procesa la gran cantidad de datos que provienen de la capa de intercambio de datos. Emplea varias tecnologías, incluidas bases de datos, computación en la nube y módulos de procesamiento de big data.
### Application service layer
La capa de servicio de aplicación consta de servicios digitales que permiten la gestión de todo el sistema IoT o partes de él mediante el uso de la abstracción proporcionada por la capa de integración. En particular, los usuarios finales pueden interactuar con los nodos IoT visualizando la información integrada y enviando comandos operativos que se implementan en la capa de integración de la información.

## System Key Requirements
- Resource control
- Energy awareness
- Quality of service (QoS)
- Interoperability
- Interference management
- Security

## System design steps

![](../../../Assets/Images/Pasted%20image%2020240418075646.png)

### 1. Definition of the system requirements
Definición de los requisitos del sistema en términos de 
- Capacidades de suministro de energía
- Restricciones de time-delay

### 2. Selection of the IoT system typology
Elección del IoT Typology, según las definiciones mencionadas anteriormente

### 3. Definition of physical layer requirements
Definición de los requisitos relacionados con la capa física en términos de:
-  Número y tipos de nodos sensores y actuadores.
-  Consumo máximo de energía para cada nodo.
-  Target uncertainty (incertidumbre objetivo), relacionada con las cantidades físicas medidas por cada sensor.
-  Target accuracy and precision (Exactitud y precisión objetivo) de los actuadores.
-  Tipología de las interfaces digitales para adquirir las medidas proporcionadas por los sensores y para
- irigir los actuadores.
-  Esfuerzo computacional para los algoritmos de procesamiento de datos que se implementarán en el nodo.
-  Time-delay requerido para el procesamiento de datos.

### 4. Definition of exchange layer requirements
Definición de los requisitos relacionados con la capa de intercambio, en términos de
-  Máximo time-delay permitido para el envío o recepción de paquete hacia o desde los nodos.
-  Tipología decomunicaciones, inalámbrica o alámbrica.
-  Topología de red.
-  Distancia máxima para las comunicaciones entre los nodos sensores/actuadores, los nodos sensores/actuadores y los concentrador, los nodos sensores/actuadores y el gateway, el concentrador y el gateway.
-  Consumo de potencia máximo permitido para la comunicación.
-  Tipo de criptografía de datos.