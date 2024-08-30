---
tags:
  - administration
  - gerencia
  - pmbok
  - planificacion
  - tiempo
---
Listado de tares que se hacen para desarrollar un proyecto.
## Procesos
### Cronograma:
#### Entradas
1. Acta
2. Plan para la dirección del proyecto
3. Factores ambientales: eventos internos o externos que no se pueden controlar, se consideran también normas y leyes.
#### Técnicas y herramientas
1. Juicio de expertos
2. Análisis de datos
3. Reuniones
#### Salida
1. Plan de gestion de cronograma

### Definir Actividades:
#### Entradas
1. Plan para la dirección del proyecto
2. Factores ambientales: eventos internos o externos que no se pueden controlar, se consideran también normas y leyes.
3. Activos de los procesos
#### Técnicas y herramientas
1. Descomposición
2. Planificación gradual
3. Juicio de expertos
4. Reuniones
#### Salida
1. Lista de actividades
2. Atributos de las actividades
3. Lista de hitos
4. Solicitudes de cambio
5. Actualizaciones al plan para la dirección del proyecto

### Secuenciar las actividades
#### Técnicas y herramientas
- Método de diagramación de precedencia (PDM): es un diagrama donde la actividad la presentas mediante nodos y se vinculan gráficamente mediante una o mas relación lógicas para indicar la secuencia en que se deben ejecutar, resultando en una secuencia.
  Existen distintos tipos de gráficos, entre ellos:
	- Inicio -> fin
	- Inicio -> inicio = cuando inicia uno puedo empezar la otra
	- Fin -> inicio = finalizo una para empezar la otra
- Determinación e integración de las dependencias: existe un cuadro de cuatro areas donde se podrían posicionar las dependencias distintas que existen.
	1. Obligatorias: requisitos legales o contractuales
	2. Discreción: en base al conocimiento se establecen las mejores practicas, como poner un antivirus, usar un software de ethical hacking
	3. Externas
	4. Internas
#### Salida
- Diagrama de red

### Estimar la duración de las actividades
#### Técnicas y herramientas
- Juicio experto: experiencia
- Estimación análoga: Se usan parámetros de un proyecto anterior cuando existe una cantidad limitada de información detallada. Usa información histórica. Se requieren actividades similares, por eso el termino usado `analogia`. Es mas rápido pero a sacrificio de ser menos exacta.
  *Tambien conocido como diagrama descendente*
- Estimación paramétrica: se usa un algoritmo para calcular la estimación, sobre una base histórico.
  *No se usa mucho*
- Estimación basadas en 3 valores: *Es la más usada.* Esta basada en:
	1. Optimista
	2. Más probable
	3. Pesimista
  Hay formulas que se pueden usar para calcular la duración o desviación.
	1. Promedio: $$\frac{O + 4\times MP + P}{6}$$
	2. Desviación: $$\frac{O - P}{6}$$
	3. Variación: $$(\frac{O - P}{6})^2$$
- Análisis de alternativas: Se mide las posibilidades entre las opciones y se escoge. Ej.: Una compañía puede tomar la decision de crear su propia aplicación o contratar o pagar para que una compañía tercera lo haga.
- Análisis de reserva: margen de error para ver imprevistos.
	1. Reserva de contingencia: reserva para imprevistos
	2. Reserva de gestion: reserva son gastos previstos, que son probables y se conocen
  Se supone que al final se suma ambas reservas al producto para sacar el costo total. Pero en la vida real empresas solo ponen una reserva porque encarece el producto/servicio.
#### Salida
Diagrama de red: es una estimación de la duración de las actividades.
### Desarrollar el cronograma


<hr>
## Datos
> Un `hito` se encuentra en el cronograma, pero en el PMBOK, no tiene tiempo, como tal tiene duración cero, pero para llegar a ello tienen que suceder varias actividades.

> Un `diagrama de red` siempre tiene un inicio y un fin.

