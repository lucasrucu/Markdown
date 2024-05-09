Feature: Vender Producto
  Como empresa
  Quiero vender productos a usuarios
  Para que puedan obtener descuentos y donar a refugios

  Scenario Outline: Vender producto sin descuento
    Given que la empresa tiene un producto con nombre "<nombreProducto>" y precio "<precio>"
    When el usuario "<nombreUsuario>" compra "<cantidad>" unidades del producto
    Then el total sin descuento es "<totalSinDescuento>"

    Examples:
      | nombreProducto | precio | nombreUsuario | cantidad | totalSinDescuento |
      | Comida         | 10     | Usuario1      | 5        | 50                |
      | Juguetes       | 15     | Usuario2      | 3        | 45                |

  Scenario Outline: Vender producto con descuento
    Given que la empresa tiene un producto con nombre "<nombreProducto>" y precio "<precio>"
    When el usuario "<nombreUsuario>" compra "<cantidad>" unidades del producto siendo su primer animal "<primerAnimal>"
    Then el total con descuento es "<totalConDescuento>"

    Examples:
      | nombreProducto | precio | nombreUsuario | cantidad | primerAnimal | totalConDescuento |
      | Comida         | 10     | Usuario1      | 5        | true         | 47.5              |
      | Juguetes       | 15     | Usuario2      | 3        | false        | 45                |
