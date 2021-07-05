import 'package:flutter/material.dart';

class App extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App>{

  //HOMESCREEN

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onUnknownRoute: (settings)=> _buildMainApp(),
    );
  }

  MaterialPageRoute _buildMainApp() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return Container(child: Text('hola esta es la primera ruta'));
    });
  }

}