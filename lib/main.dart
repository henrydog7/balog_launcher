import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool lightsOn = false;
double globePosX = 0;
double globePosY = 0;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void refresh() => setState(() {});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: Scaffold(
          body: const MyHome(),
          appBar: AppBar(leading: const MyAppBar()),
        ));
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late Function(String) refresh;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (kDebugMode) {
          print(details.globalPosition);
        }
        globePosX = details.globalPosition.dx;
        globePosY = details.globalPosition.dy;
        MyApp.refresh();
      },
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: HSLColor.fromAHSL(
                1,
                (globePosY / MediaQuery.of(context).size.height) * 360,
                1,
                globePosX / MediaQuery.of(context).size.width)
            .toColor(),
        child: Container(
          alignment: FractionalOffset.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: const BoxDecoration(
                    color: Colors.lightGreen,
                    shape: BoxShape.circle,
                  ),
                ),

              ]),
        ),
      ),
    );
  }
}

void changeLights() {
  lightsOn = !lightsOn;
}
class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          color: Colors.yellow.shade500,
          padding: const EdgeInsets.all(8),
          child: Text("Y: " + globePosY.toString()),
        ),
        Container(
          color: Colors.yellow.shade600,
          padding: const EdgeInsets.all(8),
          child: Text(
              "X: " + globePosX.toString()), //lightsOn ? "On" : "Off"),
        ),
      ],
    );
  }
}
