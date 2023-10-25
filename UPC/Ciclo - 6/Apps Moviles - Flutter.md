---
tags:
  - mobile
  - code
  - flutter
---
# Create project

Crea el proyecto en Visual Studio Code, y empieza a armar tu estructura de carpetas.

Dentro la carpeta de lib, crea:

- models
- screens
- services

#### Notas

- para conectar al internet, tienes que ingresar a la carpeta de android y activar user-permission
- se puede crear un proyecto sin todos los sistemas operativos (OS) donde se puede correr el flutter app
- para nombrar de forma correcta archivos en `dart` se debe usar un espacio entre nombres de un archivo ej: `pokemon_serivce.dart`

## Agregar dependencias

``` yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.3
```
## Crear modelo

```
class Pokemon {
	String name;
	Pokemon({required this.name});

	Pokemon.fromJson(Map<String, dynamic> json): name = json["name"];
}
```

## Crear service

Importar paquete

``` dart
import 'dart:io';
import 'dart:convert';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:http/http.dart' as http;
```

Crear servicio

``` dart
class PokemonService {
  final baseUrl = "https://pokeapi.co/api/v2/pokemon/";
  
  Future<List> getAllPokemons() async {
    http.Response response = await http.get(Uri.parse(baseUrl));
  
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final pokemonMap = jsonResponse["results"];
      pokemonMap.map((map) => Pokemon.fromJson(map)).toList();
    }
  
    return [];
  }
}
```

## Crear Screen