---
tags:
  - arquitecture
---
# ADD - Arquitectura de Diseño Detallado

## Indice

- [ADD - Arquitectura de Diseño Detallado](#add---arquitectura-de-diseño-detallado)
  - [Indice](#indice)
  - [Drivers (Atributo de calidad)](#drivers-atributo-de-calidad)
  - [Tactics](#tactics)
  - [Artefacts](#artefacts)
  - [Metrics](#metrics)
  - [Ejemplos](#ejemplos)

## Drivers (Atributo de calidad)

Un driver es un factor o una preocupación que impulsa el diseño del sistema. Los drivers son los atributos de calidad específicos que tienen un impacto significativo en la arquitectura y el diseño del sistema.

- **Rendimiento**: La capacidad de respuesta y la velocidad del sistema son fundamentales para la satisfacción del usuario. El tiempo de carga y el tiempo de respuesta deben ser óptimos.

- **Seguridad**: La protección de datos, la autenticación y la prevención de amenazas son esenciales para proteger la información del usuario y la integridad del sistema.

- **Usabilidad**: La facilidad de uso y la experiencia del usuario juegan un papel importante en la adopción y la satisfacción del usuario.

- **Disponibilidad**: El sistema debe estar disponible en todo momento, o al menos en los momentos críticos. La tolerancia a fallos y la capacidad de recuperación son componentes clave de la disponibilidad.

- **Mantenibilidad**: La capacidad de realizar actualizaciones y mantenimiento de manera eficiente es esencial para la vida útil del sistema.

- **Interoperabilidad**: La capacidad de integrarse con otros sistemas y servicios es crucial en un entorno tecnológico interconectado.

- **Confiabilidad**: El sistema debe ser robusto y confiable, minimizando los tiempos de inactividad y los errores.

- **Eficiencia energética**: En un mundo cada vez más consciente del medio ambiente, la eficiencia energética es importante tanto desde un punto de vista ecológico como económico.

- **Escalabilidad**: La capacidad de crecimiento del sistema es esencial para adaptarse a cambios en la carga y las necesidades del usuario.

- **Legalidad y cumplimiento normativo**: Cumplir con las regulaciones y leyes aplicables es fundamental para evitar problemas legales y garantizar la confianza del usuario.

## Tactics

Las tácticas son estrategias o decisiones de diseño específicas que se utilizan para lograr atributos de calidad.

- **Rendimiento** :

  - Caché de contenido estático y dinámico.
  - Paralelización de tareas.
  - Compresión de datos.
  - Optimización de consultas de base de datos.
  - Escalado horizontal o vertical de recursos.

- **Seguridad** :

  - Autenticación de dos factores (2FA).
  - Encriptación de datos en reposo y en tránsito.
  - Escaneo de seguridad regular.
  - Control de acceso basado en roles.
  - Auditorías de seguridad.

- **Usabilidad** :

  - Pruebas de usuario y retroalimentación.
  - Diseño centrado en el usuario (UCD).
  - Prototipado y pruebas de usabilidad.
  - Interfaces intuitivas y coherentes.
  - Documentación clara y accesible.

- **Disponibilidad** :

  - Réplicas de servidores y balanceo de carga.
  - Monitoreo constante del sistema.
  - Implementación de sistemas de respaldo.
  - Planes de recuperación de desastres (DRP).
  - Escalado automático en función de la demanda.

- **Mantenibilidad** :

  - Diseño modular y desacoplado.
  - Uso de estándares de codificación.
  - Implementación de patrones de diseño.
  - Pruebas unitarias y pruebas de regresión.
  - Documentación de código y procesos.

- **Interoperabilidad** :

  - Implementación de estándares de comunicación (por ejemplo, REST, SOAP).
  - Uso de API abiertas y documentadas.
  - Adaptadores y puentes para sistemas heterogéneos.
  - Pruebas de integración con otros sistemas.
  - Compatibilidad con formatos de datos comunes.

- **Confiabilidad** :

  - Implementación de mecanismos de detección y recuperación de fallos.
  - Pruebas de resistencia y estrés.
  - Redundancia de componentes críticos.
  - Monitoreo proactivo de sistemas y registros de errores.
  - Actualizaciones y parches regulares.

- **Eficiencia energética** :

  - Optimización de algoritmos y recursos.
  - Uso eficiente de servidores y hardware.
  - Programación de tareas en momentos de menor demanda.
  - Apagado automático de recursos no utilizados.
  - Utilización de fuentes de energía ecoamigables.

- **Escalabilidad** :

  - Uso de arquitecturas escalables (microservicios, contenedores).
  - Implementación de particionamiento de datos.
  - Escalado horizontal mediante la adición de instancias.
  - Uso de sistemas de colas para administrar cargas pesadas.
  - Planificación de capacidad anticipada.

- **Legalidad y cumplimiento normativo** :

  - Auditorías regulares de cumplimiento.
  - Documentación y seguimiento de requisitos legales.
  - Actualizaciones de políticas y prácticas de seguridad.
  - Formación y concienciación de los empleados sobre normativas.
  - Mantenimiento de registros y archivos necesarios para el cumplimiento.

## Artefacts

Los artefactos son elementos tangibles de documentación o componentes del sistema que se crean durante el proceso de desarrollo para representar y construir el sistema.

- **Rendimiento** :

  - Uso del patrón "Caching" para implementar una caché de contenido estático y dinámico.
  - Configuración de clustering en WildFly para escalar horizontalmente y distribuir la carga de manera eficiente.
  - Implementación de patrones de diseño de optimización, como el "Pool de Conexiones" para bases de datos.

- **Seguridad** :

  - Aplicación de patrones de seguridad como "Autenticación y Autorización" en el código, utilizando WildFly para gestionar el proceso de autenticación.
  - Uso de WildFly para configurar SSL/TLS para la encriptación de datos en tránsito.
  - Utilización de WildFly para implementar patrones de seguridad como "Firewalls de Aplicación" y "Prevención de XSS".

- **Usabilidad** :

  - Aplicación de patrones de diseño de interfaz de usuario (UI) centrados en el usuario, como "Diseño Centrado en el Usuario".
  - Utilización de tecnologías de diseño moderno, como React o Angular, para crear interfaces de usuario atractivas y responsivas.
  - Creación de wireframes y prototipos de UI para iterar en el diseño.

- **Disponibilidad** :

  - Implementación del patrón "Recuperación de Fallos" para garantizar la disponibilidad y la tolerancia a fallos.
  - Configuración de clustering en WildFly para alta disponibilidad y balanceo de carga.
  - Uso de WildFly con servidores en clúster para lograr una mayor disponibilidad y escalabilidad.

- **Mantenibilidad** :

  - Uso de patrones de diseño como "Inyección de Dependencias" para lograr una estructura de código más mantenible.
  - Documentación del código utilizando JavaDoc o herramientas similares.
  - Configuración de entornos de desarrollo y pruebas automatizadas en WildFly para facilitar las actualizaciones y pruebas.

- **Interoperabilidad** :

  - Utilización de patrones de integración como "Adaptador" para integrar sistemas externos.
  - Implementación de servicios web RESTful utilizando tecnologías modernas como JAX-RS en WildFly.
  - Configuración de puntos de conexión para la interoperabilidad con otros sistemas utilizando WildFly.

- **Confiabilidad** :

  - Uso de patrones de diseño como "Control de Transacciones" para garantizar la integridad de los datos.
  - Configuración de mecanismos de monitoreo y registro en WildFly para supervisar la salud del sistema.
  - Implementación del patrón "Redundancia" para componentes críticos en WildFly.

- **Eficiencia energética** :

  - Configuración de perfiles de rendimiento en WildFly para optimizar el uso de recursos según la demanda.
  - Utilización de tecnologías modernas de virtualización y contenedores para administrar recursos de manera eficiente.

- **Escalabilidad** :

  - Implementación del patrón "Escalabilidad Horizontal" utilizando WildFly y la adición de instancias en clúster.
  - Utilización de patrones de diseño de arquitectura escalable como "Microservicios" para permitir un crecimiento modular.

- **Legalidad y cumplimiento normativo** :

  - Documentación y seguimiento de regulaciones y normativas específicas en el desarrollo.
  - Configuración de reglas y políticas de cumplimiento en WildFly para garantizar el cumplimiento de las normativas.
  - Registro de auditorías y seguimiento de cambios para fines de cumplimiento.

## Metrics

1. **Métricas de Desempeño** :

- Estas métricas evalúan el rendimiento del software, incluyendo el tiempo de respuesta, el tiempo de carga y la eficiencia en el uso de recursos. Por ejemplo, una métrica de desempeño podría ser el tiempo promedio de respuesta de una aplicación web.

2. **Métricas de Calidad del Código** :

- Estas métricas se centran en la calidad interna del código fuente, como la legibilidad, la mantenibilidad y la complejidad. Ejemplos incluyen el índice de mantenibilidad según el análisis estático de código y la cobertura de pruebas.

3. **Métricas de Seguridad** :

- Evalúan la seguridad de la aplicación, identificando posibles vulnerabilidades y riesgos de seguridad. Un ejemplo podría ser el número de vulnerabilidades conocidas identificadas durante un análisis de seguridad.

4. **Métricas de Usabilidad** :

- Estas métricas miden la facilidad de uso y la experiencia del usuario. Pueden incluir la tasa de finalización de tareas, el tiempo que lleva realizar una tarea y la satisfacción del usuario.

5. **Métricas de Disponibilidad** :

- Evalúan la disponibilidad y la confiabilidad del sistema, incluyendo el tiempo de actividad (uptime) y el tiempo de inactividad (downtime). Una métrica común es el porcentaje de tiempo de actividad.

6. **Métricas de Tamaño y Complejidad** :

- Cuantifican el tamaño y la complejidad del software. Pueden incluir el número de líneas de código, la cantidad de funciones o métodos, y la cantidad de rutas de ejecución en un programa.

7. **Métricas de Eficiencia Energética** :

- Evalúan el consumo de energía y recursos del software. Pueden incluir mediciones de consumo de CPU, memoria y energía.

8. **Métricas de Cumplimiento Normativo** :

- Verifican si el software cumple con regulaciones y normativas específicas de la industria o el gobierno. Esto puede incluir la documentación de evidencia de cumplimiento.

9. **Métricas de Proceso de Desarrollo** :

- Evalúan la eficiencia y la calidad del proceso de desarrollo en sí mismo. Pueden incluir métricas relacionadas con la velocidad de entrega, la satisfacción del cliente y la calidad de los entregables.

10. **Métricas de Interoperabilidad** :

- Evalúan la capacidad del software para integrarse con otros sistemas. Esto podría incluir la medición de la compatibilidad con estándares de la industria.

## Ejemplos

![Tabla de ADD](/Assets/Images/tabla_add_001.png)

![Table2 de ADD](/Assets/Images/tabla_add_002.png)
