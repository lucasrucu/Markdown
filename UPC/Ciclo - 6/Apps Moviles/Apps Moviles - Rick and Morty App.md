# Flutter App - Rick and Morty
## Create project

``` bash
flutter create project_name
```

## Add dependencies

``` yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^12.1.1
  http: ^1.1.0
  path: ^1.8.3
  provider: ^6.1.1
  sqflite: ^2.3.0
```

or use terminal

``` bash
flutter pub add provider http
```

> Se pueden agregar varios a la vez como el caso de arriba. Provider y Http son dos dependencias distintas.
## Edit `main.dart`

``` dart
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.green,
        ),
      ),
      home: const Navigation(),
    );
  }
}

```

## Crear el `Navigation`

Crear el archivo dentro de una carpeta `widgets`.

``` dart
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/favorites_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/list_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
      ),
      body: IndexedStack(
        index: index,
        children: const <Widget>[
          HomeScreen(),
          ListScreen(),
          FavoriteScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int tappedIndex) {
          setState(() {
            index = tappedIndex;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: index == 0
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: index == 1
                ? const Icon(Icons.list)
                : const Icon(Icons.list_outlined),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: index == 2
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

```