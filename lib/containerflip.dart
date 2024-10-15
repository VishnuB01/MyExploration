import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlipAnimationDemo(),
    );
  }
}

class FlipAnimationDemo extends StatefulWidget {
  @override
  _FlipAnimationDemoState createState() => _FlipAnimationDemoState();
}

class _FlipAnimationDemoState extends State<FlipAnimationDemo>
    with SingleTickerProviderStateMixin {
  bool _isFlipped = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  void _flip() {
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flip Animation')),
      body: Center(
        child: GestureDetector(
          onTap: _flip,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.rotationY(_controller.value * 3.14159),
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: _isFlipped
                      ? Transform(
                    transform: Matrix4.rotationY(3.14159),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter text',
                        ),
                      ),
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://example.com/your-image.jpg',
                      fit: BoxFit.cover,
                      width: 300,
                      height: 200,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
