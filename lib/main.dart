import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Builder',
      home: FutureBuilderApp(),
    );
  }
}
class FutureBuilderApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => FutureBuilderAppState();
}
class FutureBuilderAppState extends State<FutureBuilderApp>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}