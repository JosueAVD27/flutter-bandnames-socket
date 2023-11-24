import 'package:flutter/material.dart';
import 'package:flutter_application/pages/home.dart';

void main() => runApp(name());

class name extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => HomePage(),
      },
    );
  }
}