import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxbus/rx_bus.dart';
import 'package:rxbus_example/event/chang_title.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String received;
  String title = "EventBus example app";
  final String TAG = "EventBus";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                    child: Text('Update First Page Title'),
                    onPressed: () =>
                        RxBus.post(ChangeTitleEvent("Update Title by other page"), tag: TAG)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
