



import 'package:flutter/material.dart';
import 'package:locationapp/gpslocation/gpslocation.dart';
import 'package:locationapp/googlemaps/mapgoogle.dart';

//var api_key ="AIzaSyA2jmQy0wkL4Ge4pgFylDhlrxc1DSfy4Xg";
void main() {
 // MapView.setApiKey(api_key);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GPS Location Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AskForPermission(),
    );
  }
}

