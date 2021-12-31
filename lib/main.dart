import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

bool lightsOn = false;
double globePosX = 0;
double globePosY = 0;
final GlobalKey _widgetKey = GlobalKey();

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: Scaffold(
          body: MyHome(refresh: _refresh),
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
    required this.refresh,
  }) : super(key: key);

  final Function refresh;

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
          print(_widgetKey.currentContext?.size?.width);
        }
        globePosX = details.localPosition.dx;
        globePosY = details.localPosition.dy;
        widget.refresh();
      },
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: HSLColor.fromAHSL(
                1,
                globePosY < < _widgetKey.currentContext?.size?.width.toInt() ? (globePosY / MediaQuery.of(context).size.height) * 360,
                1,
                globePosX / MediaQuery.of(context).size.width)
            .toColor(),
        child: Container(
          alignment: FractionalOffset.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Container(
                //   width: 600.0,
                //   height: 300.0,
                //   decoration: const BoxDecoration(
                //     color: Colors.lightGreen,
                //     shape: BoxShape.circle,
                //   ),
                // ),
                CustomPaint(
                  size: Size(
                      MediaQuery.of(context).size.width.toDouble(),
                      (MediaQuery.of(context).size.height.toDouble()) / 2
                  ),
                  painter: CurvedPainter(),
                )
              ]),
        ),
      ),
    );
  }
}

// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawArc(
//       const Offset(0, 0) & const Size(100, 100),
//       0.0,
//       180 ,
//       true,
//       Paint(),
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
//
// }
class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

void changeLights() {
  lightsOn = !lightsOn;
}
