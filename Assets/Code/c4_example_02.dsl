workspace "SISTEMA DE VIATICOS" {
   // impliedRelationships "false"
   //!identifiers "hierarchical"
   
   model {
      // USUARIO
      trabajador = person "TRABAJADOR" "" "Persona"
      supervisor = person "SUPERVISOR" "" "Persona"
      twilio = softwareSystem "TWILIO" "" "Software"
      email = softwareSystem "EMAL" "" "Software"
      rrhh = softwareSystem "RECURSOS HUMANOS" "" "Software"
      
      // SOFTWARE
      viaticos = softwareSystem "SISTEMA DE VIATICOS" "" "Software" {
         // CONTENEDORES
         app = container "App Movil" "" "Kotlyn" "App"
         api = container "Api GateWay" "Api GateWay" "API" "Componente"
         broker = container "Broker" "" "" "Componente"
         hospedaje = container "Hospedaje" "" "" "Componente"
         movilidades = container "Movilidades" "" "" "Componente" {
            ticket = component "Ticket" "" "" "Componente"
            traslado = component "Traslado" "" "" "Componente"
            vehiculo = component "Vehiculo" "" "" "Componente"
            alquilerVehiculo = component "Alquiler vehiculo" "" "" "Componente"
            controller = component "Controller" "" "" "Componente"
            conector = component "Conector" "" "" "Componente"
         }
         viaticos2 = container "Viaticos" "" "" "Componente"
         db1 = container "DB1" "DB" "DB" "DB"
         db2 = container "DB2" "DB" "DB" "DB"
         db3 = container "DB3" "DB" "DB" "DB"
         
      }
      
      // RELACIONES
      // CONTEXTO
      trabajador -> viaticos "usa"
      supervisor -> viaticos "usa"
      viaticos -> twilio "usa"
      viaticos -> email "usa"
      viaticos -> rrhh "usa"
      
      // CONTENEDORES
      trabajador -> app "usa"
      app -> api "usa"
      api -> broker "usa"
      broker -> hospedaje "usa"
      broker -> movilidades "usa"
      broker -> viaticos2 "usa"
      hospedaje -> db1 "usa"
      movilidades -> db2 "usa"
      viaticos2 -> db3 "usa"
      api -> rrhh "usa"
      broker -> twilio "usa"
      broker -> email "usa"
      
      // COMPONENTES
      broker -> controller "usa"
      controller -> ticket "usa"
      controller -> vehiculo "usa"
      controller -> traslado "usa"
      ticket -> conector "usa"
      
   }
   
   views {
      systemContext viaticos "Contexto" "Diagrama de contexto del sistema" {
         include trabajador
         include supervisor
         include viaticos
         include twilio
         include email
         include rrhh
      }
      
      container viaticos "Contenedores" "Diagrama de contenedores del sistema" {
         include trabajador
         include app
         include api
         include broker
         include hospedaje
         include movilidades
         include viaticos2
         include db1
         include db2
         include db3
         include rrhh
         include twilio
         include email
      }
      
      component api "Componentes" "Diagrama de componentes del sistema" {
         include ticket
         include traslado
         include vehiculo
         include controller
         include conector
         include alquilerVehiculo
         include broker
      }
      
      styles {
         element "Persona" {
            shape "Person"
            background "#232ecd"
            color "#ffffff"
         }
         element "PersonaIt" {
            shape "Person"
            background "#26cf48"
            color "#ffffff"
         }
         element "Software" {
            shape "RoundedBox"
            background "#D416C4"
         }
         element "App" {
            shape "MobileDeviceLandscape"
            background "#E97C28"
         }
         element "Componente" {
            shape "Component"
            background "#d49816"
         }
         element "DB" {
            shape "Cylinder"
            background "#ec0e0e"
            color "#ffffff"
         }
      }
   }
}