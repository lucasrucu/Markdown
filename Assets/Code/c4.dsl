workspace "Gateway FTR" {
   impliedRelationships "false"
   !identifiers "hierarchical"
   
   model {
      // Stakeholders
      EjecutivoCuenta = person "Ejecutivo de Cuenta" "Ejecutivo de Cuenta" "Persona"
      Cliente = person "Cliente" "Cliente" "Persona"
      IngenieroSoporte = person "Ingeniero de Soporte" "Ingeniero de Soporte" "PersonaIt"
      
      // Servicios
      EmpresaEmisoraPrestamo = softwareSystem "Empresa Emisora de Prestamo" "Empresa Emisora de Prestamo" "Servicio"
      AppWebBancaria = softwareSystem "App web bancaria" "App web bancaria" "Servicio"
      AppAgenciaBancaria = softwareSystem "App agencia bancaria" "App agencia bancaria" "Servicio"
      
      // Software
      GatewayFTR = softwareSystem "Gateway FTR" "Gateway FTR" "Software"{
         // Contenedores
         Redirector = container "Redirector" "Redirector" "Contenedor"
         ApiGateWaySoap = container "Api GateWay Soap" "Api GateWay Soap" "Contenedor"
         ServidorApps = container "Servidor Apps" "Servidor Apps" "Contenedor"
         
         // Microservicios
         ApiGateWayRest = container "Api GateWay Rest" "Api GateWay Rest" "MicroServicio" "MicroServicio"
         ServicioConsultas = container "Servicio Consultas" "Servicio MicroServicio" "MicroServicio" "MicroServicio" {
            Empresa = component "Empresa" "Empresa" "MicroServicio" "Folder"
            Monitor = component "Monitor" "Monitor" "MicroServicio" "Folder"
            LogEventos = component "Log Eventos" "Log Eventos" "MicroServicio" "Folder"
            HistoriaFraudes = component "Historia Fraudes" "Historia Fraudes" "MicroServicio" "Folder"
         }
         ServicioPagos = container "Servicio Pagos" "Servicio Pagos" "MicroServicio" "MicroServicio"
         ConectorEmpresa = container "Conector Empresa" "Conector Empresa" "MicroServicio" "MicroServicio"
         
         // Base de datos
         DB = container "DB" "DB" "DB" "DB"
      }
      
      // Relaciones
      // Contexto
      Cliente -> AppWebBancaria "Realiza operaciones bancarias" 
      Cliente -> AppAgenciaBancaria "Realiza operaciones bancarias"
      AppWebBancaria -> GatewayFTR "Realiza operaciones bancarias"
      AppAgenciaBancaria -> GatewayFTR "Realiza operaciones bancarias"
      GatewayFTR -> EmpresaEmisoraPrestamo "Realiza operaciones bancarias"
      EjecutivoCuenta -> EmpresaEmisoraPrestamo "Realiza operaciones bancarias"
      IngenieroSoporte -> GatewayFTR "Realiza operaciones bancarias"
      
      // Contenedores
      AppWebBancaria -> GatewayFTR.Redirector "Realiza operaciones bancarias"
      AppAgenciaBancaria -> GatewayFTR.Redirector "Realiza operaciones bancarias"
      GatewayFTR.Redirector -> GatewayFTR.ApiGateWayRest "Realiza operaciones bancarias"
      GatewayFTR.Redirector -> GatewayFTR.ApiGateWaySoap "Realiza operaciones bancarias"
      GatewayFTR.ApiGateWayRest -> GatewayFTR.ServicioConsultas "Realiza operaciones bancarias"
      GatewayFTR.ApiGateWayRest -> GatewayFTR.ServicioPagos "Realiza operaciones bancarias"
      GatewayFTR.ApiGateWaySoap -> GatewayFTR.ServidorApps "Realiza operaciones bancarias"
      GatewayFTR.ServidorApps -> EmpresaEmisoraPrestamo "Realiza operaciones bancarias"
      GatewayFTR.ServidorApps -> GatewayFTR.DB "Realiza operaciones bancarias"
      GatewayFTR.ServicioConsultas -> GatewayFTR.ConectorEmpresa "Realiza operaciones bancarias"
      GatewayFTR.ServicioPagos -> GatewayFTR.ConectorEmpresa "Realiza operaciones bancarias"
      GatewayFTR.ConectorEmpresa -> GatewayFTR.DB "Realiza operaciones bancarias"
      IngenieroSoporte -> GatewayFTR.ServicioConsultas "Realiza operaciones bancarias"
      
      // Componentes
      GatewayFTR.ApiGateWayRest -> GatewayFTR.ServicioConsultas.Monitor "Realiza operaciones bancarias"
      GatewayFTR.ServicioConsultas.Monitor -> GatewayFTR.ServicioConsultas.LogEventos "Realiza operaciones bancarias"
      GatewayFTR.ServicioConsultas.Monitor -> GatewayFTR.ServicioConsultas.Empresa "Realiza operaciones bancarias"
      IngenieroSoporte -> GatewayFTR.ServicioConsultas.Monitor "Realiza operaciones bancarias"
      GatewayFTR.ServicioConsultas.LogEventos -> GatewayFTR.ServicioConsultas.HistoriaFraudes "Realiza operaciones bancarias"
      GatewayFTR.ServicioConsultas.LogEventos -> GatewayFTR.ConectorEmpresa "Realiza operaciones bancarias"
   }
   
   views {
      systemContext GatewayFTR "Contexto" "Diagrama de contexto del sistema" {
         include Cliente
         include AppWebBancaria
         include AppAgenciaBancaria
         include GatewayFTR
         include EmpresaEmisoraPrestamo
         include EjecutivoCuenta
         include IngenieroSoporte
      }
      
      container GatewayFTR "Contenedores" "Diagrama de contenedores del sistema" {
         include Cliente
         include IngenieroSoporte
         include EmpresaEmisoraPrestamo
         include AppWebBancaria
         include AppAgenciaBancaria
         include GatewayFTR.Redirector
         include GatewayFTR.ApiGateWayRest
         include GatewayFTR.ServicioConsultas
         include GatewayFTR.ServicioPagos
         include GatewayFTR.ApiGateWaySoap
         include GatewayFTR.ServidorApps
         include GatewayFTR.ConectorEmpresa
         include GatewayFTR.DB
         
      }
      
      component GatewayFTR.ServicioConsultas "Componentes" "Diagrama de componentes del sistema" {
         include IngenieroSoporte
         include GatewayFTR.ApiGateWayRest
         include GatewayFTR.ConectorEmpresa
         include GatewayFTR.ServicioConsultas.Monitor
         include GatewayFTR.ServicioConsultas.Empresa
         include GatewayFTR.ServicioConsultas.LogEventos
         include GatewayFTR.ServicioConsultas.HistoriaFraudes
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
         
         element "MicroServicio" {
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