Domain driven design es un enfoque que constantemente tiene cambios.
	Identifica los dominios, el core, soporte y genérico.
	Establecer roles y responsabilidades
	Establecer equipos
	Al final, empiezas a codear.

Event storming: para poder establecer los bounded context

Quienes participan. Participan todos. Nadie en particular esta en la reunion, nomas mientras mas enfoque hay, mejor, pero que no sea muy grande. Un estimado de 10 participantes es lo adecuado.

### Event Storming:
#### Step 1: Unstructured Exploration
Lluvia de ideas de los eventos del dominio, que son cosas interesantes que ocurren en el negocio. Se escriben en tiempo pasado; describiendo cosas que ya sucedieron. Se establecen al azar, no hay orden, se colocan en post sticks.
Ejemplos:
- flight fare booked
- shipping cost calculated
- request declined
- request approved
- order shipped
- notification sent
- calendar  event created
- flight tickets booked
[Estos normalmente se representan en el event storming como cuadrados naranjas]
#### Step 2: Timelines
Se revisan los eventos y se organizan en orden en que ocurren. Los eventos deben comenzar con el happy path: flujo que describe un escenario empresarial exitoso. Una vez completado el *happy path* se agregan escenarios alternativos.

#### Step 3: Pain Points
Ya organizados, identifica puntos que requieren atención. Estos te podrían traer problemas, sean pasos que se deben hacer a mano o requieran de mayor esfuerza que los otros puntos.
Ejemplo: Para un evento como *Flight fare booked*, podría tener el pain point de *How are the prices computed*.
[Estos en el event storming se representan en un rombo, normalmente rosado]

#### Step 4: Pivotal Points
Buscar eventos comerciales que indiquen un cambio en el contexto, o inicio de una fase nueva. Se denominan eventos fundamentales y se marcan con una barra vertical que atraviesan el evento importante.

#### Step 5: Commands
Un comando describe que fue lo que desencadeno el evento o flujo de eventos. Describen operaciones del sistema y se formulan en imperativo.
Ejemplo:
- Submit order
[Son cuadrados azules, normalmente se agrega un cuadro amarillo que muestra cual fue el actor que lo ejecuto]

#### Step 6: Policies
Este es donde se desencadena una ejecución de un comando. Se ejecuta automáticamente cuando ocurre un evento de dominio.
Ejemplo:
	Evento: shipment approved
	Policy: alguna póliza que se ejecuta
	Command: ship order
[Son cuadros morados que se agregan a un evento]

#### Step 7: Read Models
Es un *view* de datos que el actor necesita para poder ejecutar un comando. Pueden ser pantallas.
Ejemplo: Cart
[Se coloca como un cuadrado al costado del timeline, lado izquierdo, de color verde]

#### Step 8: External Systems
Se define como cualquier systema que no forma parte de el dominio que se esta explorando. Puede ejecutar comandos, como una ayuda.
Ejemplo: un CRM
[Un cuadro rojo]

#### Step 9: Aggregates
Cuando todos los eventos están representados, los participantes pueden comenzar a pensar en organizar conceptos. Un agregado recibe comandos y produce eventos.
[Un ciadrado grande que se encuentra despues de comadnos y antes de eventos, este es de color amarillo claro]

#### Step 10: Bounded Contexts
Cada bounded context debe tener su respectivo event storming. Estos grupos se forman a partir de políticas o porque están estrechamente relacionados.

### Quality Atribute Escenario

![](../../../Assets/Images/Pasted%20image%2020240409204647.png)

