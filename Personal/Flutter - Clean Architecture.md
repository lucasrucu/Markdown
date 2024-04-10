---
tags:
  - code
  - clean_code
  - arquitecture
  - flutter
  - mobile
---
Usando una arquitectura para una aplicación mas grande que solo las apps demo que realizamos dentro nuestra clase donde usamos [[../UPC/Ciclo - 6/Apps Moviles/Apps Moviles - Flutter]].

# Indice

- [Indice](#indice)
- [Crear un nuevo proyecto](#crear-un-nuevo-proyecto)
  - [Importar paquetes/dependencias](#importar-paquetesdependencias)
  - [Arquitectura de la aplicación](#arquitectura-de-la-aplicación)
- [Codigo](#codigo)
  - [Core](#core)
  - [Domain](#domain)
  - [Data](#data)

# Crear un nuevo proyecto

Si te encuentras dentro Visual Studio Code puedes seguir los siguientes pasos:

1. Presionar `Ctrl + Shift + P`
2. Escribir `flutter`
3. Seleccionar `Flutter: New Project`
4. Seleccionar la carpeta donde se creara el proyecto
5. Asignarle un nombre al proyecto
6. Antes de crear el proyecto, en la esquina superior de la ventana, se puede seleccionar para que tipo de dispositivo se creara la aplicación.

Si se quiere crear un proyecto desde la terminal se puede usar el siguiente comando:

```bash
flutter create --org com.example --project-name nombre_proyecto
```

Si desea crear el proyecto para solo un tipo de dispositivo se puede usar el siguiente comando:

```bash
flutter create --org com.example --project-name nombre_proyecto -platforms=android .
```

> Aun no pruebo el comando, pero creo que es asi

## Importar paquetes/dependencias

Dentro el archivo `pubspec.yaml` se importan las dependencias que se van a usar en la aplicación.

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  flutter_svg: ^2.0.7
  # State managment
  flutter_bloc: ^8.1.3
  # Comparing dart objects
  equatable: ^2.0.5
  # Service locator
  get_it: ^7.6.4
  # dateFormat
  intl: ^0.18.1
  # Database
  floor: ^1.4.2
  # API requests
  retrofit: ^4.0.3
  # Hooks
  flutter_hooks: ^0.20.3
  # Cached images
  cached_network_image: ^3.3.0
```

> Actualizado el 2023-10-12

Y también se usaran las dependencias para desarrollo.

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  # Code generation
  retrofit_generator: ^8.0.1
  # Database
  floor_generator: ^1.4.2
  # Build runner
  build_runner: ^2.4.6
```

> Actualizado el 2023-10-12

## Arquitectura de la aplicación

Si se sigue la arquitectura de [[Clean Arquitecture]] se obtendrá una arquitectura de carpetas similar a esta:

```bash
lib
├── core
│   ├── constants
│   │   ├── constants.dart
│   ├── reasources
│   │   ├── data_state.dart
├── features
│   ├── feature1
│   │   ├── data
│   │   │   ├── data_source
│   │   │   │   ├── remote
│   │   │   │   ├── local
│   │   │   ├── models
│   │   │   ├── repositories
│   │   ├── domain
│   │   │   ├── entities
│   │   │   ├── repositories
│   │   │   ├── usecases
│   │   ├── presentation
│   │   │   ├── bloc
│   │   │   ├── pages
│   │   │   ├── widgets
```

Se seguira duplicando esta estructura para los demas features que se vayan creando.
Al final se agregara una foto cuando se termine de crear la aplicación.

# Codigo

## Core

En esta capa se guardan los archivos que se usaran en toda la aplicación, como por ejemplo los `constants` o los `data_state`.

Ejemplo de un `constants`, con nombre de archivo `constants.dart`:

```dart
const String newsApiBaseUrl = "https://newsapi.org/v2/";
const String apiKey = "0f7bd4fd30fb4bfd8160d13604e7"
```

Ejemplo de un `data_state`, con nombre de archivo `data_state.dart`:

```dart
import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioError? error;
  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(DioError error) : super(error: error);
}
```

## Domain

La razon por empezar en esta capa es para porque el domain se supone que no debe depender de ninguna otra capa, deberia poder ser usado en cualquier otra aplicación sin tener que importar nada mas.

Ejemplo de un `entity`, con nombre de archivo `article_entity.dart`:

```dart
import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity(
      {this.id,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  @override
  List<Object?> get props {
    return [
      id,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content
    ];
  }
}
```

Ejemplo de un `repository`, con nombre de archivo `article_repository.dart`:

```dart
import 'package:flutter_pokedex/core/resources/data_state.dart';
import 'package:flutter_pokedex/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
```

Ejemplo de un `usecase`, con nombre de archivo `get_news_articles_usecase.dart`:

```dart
// Aun esta pendiente
```

## Data

Ejemplo de un `model`, con nombre de archivo `article_model.dart`:

```dart
import 'package:flutter_pokedex/features/daily_news/domain/entities/article.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  });
  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      urlToImage: map['urlToImage'] ?? "",
      publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }
}
```

> Razon por la que se crea un modelo y no se usa el entity directamente es porque el entity no deberia tener dependencias de ninguna otra capa, y el modelo si puede tener dependencias de otras capas. A futuro esto servira para poder cambiar la fuente de datos sin tener que cambiar el entity.

Ejemplo de un `repository`, con nombre de archivo `article_repository_impl.dart`:

```dart
import 'package:flutter_pokedex/core/resources/data_state.dart';
import 'package:flutter_pokedex/features/daily_news/data/models/article.dart';
import 'package:flutter_pokedex/features/daily_news/domain/entities/article.dart';
import 'package:flutter_pokedex/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() {
    // TODO: implement getNewsArticles
    throw UnimplementedError();
  }
}
```

Ejemlo de un `data source`, con nombre de archivo `new_api_service.dart`:

```dart
import 'package:flutter_pokedex/core/constants/constants.dart';
import 'package:flutter_pokedex/features/daily_news/data/models/article.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsApiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;
  @GET("top-headlines")
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("apikey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}
```

> Ver que en la 5ta linea se importa el archivo `news_api_service.g.dart`, este archivo se genera automaticamente cuando se corre el comando `flutter pub run build_runner build --delete-conflicting-outputs` o `flutter pub run build_runner watch --delete-conflicting-outputs` para que se genere automaticamente cada vez que se haga un cambio en el archivo `news_api_service.dart` se puede usar el comando `flutter pub run build_runner watch --delete-conflicting-outputs`.

```
flutter pub build_runner build
```

> El archivo aparte se encuentra dentro de un folder de nombre remote, pues es la fuente de datos remota, pero tambien se puede crear un folder de nombre local para la fuente de datos local.

