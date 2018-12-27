import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxbus/rxbus.dart';
import 'package:rxbus_example/new_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //注册默认的监听器
    registerBus();
  }

  void registerBus() {
    RxBus.register<ChangeTitleEvent>().listen((event) => setState(() {
          title = event.title;
          received = event.title;
        }));
    RxBus.register<ChangeTitleEvent>(tag: TAG).listen((event) => setState(() {
          title = event.title;
        }));
  }

  String received;
  String title = "EventBus example app";
  final String TAG = "EventBus";

  @override
  void dispose() {
    super.dispose();
    RxBus.destroy();
  }

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
                    child: Text('Send event (No Tag notify all same event)'),
                    onPressed: () {
                      RxBus.post(ChangeTitleEvent("Changed by event"));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                    child: Text('Send event with tag (notify all same tag event)'),
                    onPressed: () =>
                        RxBus.post(ChangeTitleEvent("Changed title event with Tag"), tag: TAG)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                    child: Text('New Page'),
                    onPressed: () => navigatorKey.currentState.push(
                          CupertinoPageRoute(
                            builder: (BuildContext context) => NewPage(),
                          ),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Received is $received '),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('First Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeTitleEvent {
  String title;

  ChangeTitleEvent(this.title);
}
