import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:future_builder/test/testModel.dart';
import 'package:path_provider/path_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterDemo(storage: CounterStorage()),
    );
  }
}

class CounterStorage {
  Future<File> get _localFile async {
    debugger();
    final directory = await getApplicationDocumentsDirectory(); 
    //Khởi tạo file  có đuôi là txt để cho ta lưu dữ liệu vào đó trước.
    return File('${directory.path}/testStorage.txt');
  }

  Future<dynamic> readCounter() async {
      final file = await _localFile;
      String contents = await file.readAsString();
      debugger();
      return jsonDecode(contents);
  }

  Future<File> writeCounter(dynamic counter) async {
    // có thể parse thành json từ List hoặc Map đều được
    String encodedDoughnut = jsonEncode(counter);
    final file = await _localFile;


    // Write the file
    return file.writeAsString(encodedDoughnut);
  }
}

class FlutterDemo extends StatefulWidget {
  final CounterStorage storage;

  FlutterDemo({Key key, @required this.storage}) : super(key: key);

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  double _counter = 0;
  List<Doughnut> listResult = [];
  var result;
  @override
  void initState() {
    super.initState();
    // dữ liệu lấy ra từ storage ra dạng json
    widget.storage.readCounter().then((value) {
      value.map((item) {
        var v = Doughnut.fromJson(item);
        // bug không map đc list ra thêm vào mảng.
        listResult.add(v);
      }).toList();
      debugger();
      setState(() {
        result = listResult;
      });
    });
  }

  Future<File> _incrementCounter() {
    var list = [
      Doughnut('demo2', 12),
      Doughnut('demo', 10),
      Doughnut('demo3', 15),
    ];
    
    // Có thể truyền đi dạng list hay dạng map từng phần tử đều đc
    var t = Doughnut('demo2', 12).toJson();
    debugger();
    // Write the variable as a string to the file.
    return widget.storage.writeCounter(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(
        child: Text(
          'Button tapped ${listResult[2].price}'// time${_counter == 1 ? '' : 's'}.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}