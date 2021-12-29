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

  void _refresh() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: Scaffold(
          body: MyHome(onChanged: _refresh),
          appBar: AppBar(

            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          ),
        ));
  }
}

class MyHome extends StatefulWidget {
  @override
  const MyHome({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function onChanged;

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (kDebugMode) {
          print(details.globalPosition);
        }
        globePosX = details.globalPosition.dx;
        globePosY = details.globalPosition.dy;
        widget.onChanged();
      },
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: HSLColor.fromAHSL(
            1,
            (globePosY / MediaQuery
                .of(context)
                .size
                .height) * 360,
            1,
            globePosX / MediaQuery
                .of(context)
                .size
                .width)
            .toColor(),
        child: Container(
          alignment: FractionalOffset.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 600.0,
                  height: 300.0,
                  decoration: const BoxDecoration(
                    color: Colors.lightGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                CustomPaint(
                  size: Size(100, 100),
                  painter: MyPainter(),
                )
              ]),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      const Offset(0, 0) & const Size(100, 100),
      0.0,
      180.0  ,
      true,
      Paint(),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}


void changeLights() {
  lightsOn = !lightsOn;
}


