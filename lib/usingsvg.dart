import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Usingsvg extends StatefulWidget {
  const Usingsvg({super.key});

  @override
  State<Usingsvg> createState() => _UsingsvgState();
}

class _UsingsvgState extends State<Usingsvg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter custom clipper example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width, // Set the desired width
              height: 400, // Set the desired height
              child: Container(
                color: Colors.grey,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/container.svg',
                        fit: BoxFit.fitHeight, // Make sure the SVG covers the container

                      ),
                    ),
                    Container(), // Optional container for additional layering
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Usingsvg(),
    );
  }
}
