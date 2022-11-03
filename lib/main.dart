import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  final TransformationController _transformationController =
      TransformationController();
  final TextEditingController _xCoordinateController = TextEditingController();
  final TextEditingController _yCoordinateController = TextEditingController();
  final TextEditingController _zoomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Assignment'),
        backgroundColor: const Color(0xFF444444),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const SizedBox(
            width: 20.0,
          ),
          Container(
            width: 400,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF444444)
              )
            ),
            child: InteractiveViewer(
              transformationController: _transformationController,
              child: CustomPaint(
                painter: OpenPainter(),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: _xCoordinateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "X Value"),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: _yCoordinateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Y Value"),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: _zoomController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Zoom Level (1-10)"),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          ElevatedButton(
              onPressed: () {
                final double scale = double.parse(_zoomController.text);
                final x= -double.parse(_xCoordinateController.text)*(scale-1);
                final y= -double.parse(_yCoordinateController.text)*(scale-1);
                final zoomed = Matrix4.identity()
                  ..translate(x,y)
                  ..scale(scale);
                final value = zoomed;
                _transformationController.value= value;
              },
              child: const Text("ZOOM")),
          const SizedBox(
            width: 20.0,
          ),
          ElevatedButton(
              onPressed: () {
                _transformationController.value = Matrix4.identity();
              },
              child: const Text("RESET"))
        ]),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xff63aa65)
      ..strokeCap = StrokeCap.round //rounded points
      ..strokeWidth = 10;
    //list of points
    var points = [
      const Offset(50, 50),
      const Offset(80, 70),
      const Offset(380, 175),
      const Offset(80, 175),
      const Offset(30, 175),
      const Offset(380, 75),
      const Offset(200, 175),
      const Offset(150, 105),
      const Offset(300, 75),
      const Offset(320, 200),
      const Offset(93, 125),
      const Offset(73, 125),
      const Offset(210, 127),
      const Offset(89, 121),
      const Offset(250, 115),
      const Offset(89, 150),
      const Offset(170, 160),
      const Offset(20, 125),
      const Offset(10, 125),
    ];
    //draw points on canvas
    canvas.drawPoints(PointMode.points, points, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
