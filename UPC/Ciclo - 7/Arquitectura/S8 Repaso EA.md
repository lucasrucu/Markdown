# Diagramming
## Useful Links
[Microservice layer diagram](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/microservice-application-layer-implementation-web-api) has some images regarding microservice and overall diagrams to guide in the creation of C4 diagrams.
[Visual Paradigm Online](https://online.visual-paradigm.com/drive/#diagramlist:proj=0&dashboard) is useful for creating your C4 diagrams.
[Lucid Chart](https://lucid.app/users/login#/login) es buena para elaborar los diagramas de clase UML. 

> Para los diagramas UML de lucid chart, ingrese con tu sesion primero y despues busca en templates uml. Recuerda tener el idioma en ingels, con español no sale.

## Class UML

![](../../../Assets/Images/Pasted%20image%2020240508194542.png)

# Caso HireVue
## Notas
Usuarios:
- reclutadores y gerentes de contratacion
- candidatos

Web App
App mobile para *Candidatos*
App mobile para *Reclutadores*

Caracteristicas de HueVue:
- video interviewing
- assessment:
	- uso de HireVue: AI para evaluar
	- equipo de I/O psicholigst
	- experiencia automatizada, unificada y divertida
	- invita solicitantes a completar evaluacion
	- mide habilidades
	- llena de competencias
- conversational ai:
	- envia mensajes: sms & wasap
- scheduling:
	- envia mensajes: sms & correo
	- calendario
- interview builder
- text recruting:
	- envia notificaciones: sms
- seguridad:
	- certificado por terceros

Quality atributes:
- disponibilidad

Requisitos
- single sign on
- tecnologias google
- microservicios
- serverless
- ddd
- cqrs
- eda

## Solucion
Pregunta 1: diagrama de contexto
![](../../../Assets/Images/Pasted%20image%2020240508215207.png)

Pregunta 2: diagrama de contenedores
![](../../../Assets/Images/Untitled%20(6).png)

Pregunta 3: diagrama de classes UML
![](../../../Assets/Images/Pasted%20image%2020240509001504.png)
Pregunta 4:
![](../../../Assets/Images/Pasted%20image%2020240509103224.png)