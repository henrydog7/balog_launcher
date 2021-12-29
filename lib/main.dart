import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool lightsOn = false;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: const Scaffold(
          body: MyHome(),
        ));
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  double dragDistance = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onPanUpdate: (details) => setState((){
        if (kDebugMode) {
          print(details.delta.dy);
        }
        dragDistance = details.delta.dy;
        }),

      child: Container(
        constraints: const BoxConstraints.expand(),
        color: HSLColor.fromAHSL(1, 120, 1.0, 1).toColor(),
        child: Container(
          alignment: FractionalOffset.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    lightsOn ? Icons.flashlight_on : Icons.flashlight_off,
                    color: lightsOn ? Colors.yellow.shade600 : Colors.grey,
                    size: 60,
                  ),
                ),
                Container(
                  color: Colors.yellow.shade600,
                  padding: const EdgeInsets.all(8),
                  child: Text(dragDistance.toString()),//lightsOn ? "On" : "Off"),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

void changeLights() {
  lightsOn = !lightsOn;
}
