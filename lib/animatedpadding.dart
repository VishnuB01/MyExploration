import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimationHandler {
  // Initial values for translation and rotation
  double translateYBubble = 0;
  double translateYCoach = 10;
  double translateXCoach = 0.0; // Initial horizontal translation for Coach
  double translateX = 0.0; // Initial horizontal translation
  double rotationAngle = 320 * (3.141592653589793 / 180); // Initial rotation angle for bubble
  String textContent = 'Did everything go well yesterday?';

  void moveLeftAndUp() {
    translateXCoach = 0.0; // Move left by 0 logical pixels
    translateYCoach = -20.0; // Move up by 20 logical pixels
  }

  void animatePaddingAndRotation() {
    translateYBubble = -10; // Adjust as needed
    translateYCoach = 0; // Adjust as needed
    rotationAngle = 20 * (3.141592653589793 / 180); // Rotate by 20 degrees (converted to radians)
  }

  void moveRight() {
    translateX = 50; // Change this value based on how far right you want it to move
    textContent = 'Did everything go well \nyesterday?';
  }

  void resetAnimation() {
    translateYBubble = 0;
    translateYCoach = 10;
    translateXCoach = 0.0;
    translateX = 0.0;
    rotationAngle = 320 * (3.141592653589793 / 180);
    textContent = 'Did everything go well yesterday?';
  }
}

class AnimatedColumnExample extends StatefulWidget {
  @override
  _AnimatedColumnExampleState createState() => _AnimatedColumnExampleState();
}

class _AnimatedColumnExampleState extends State<AnimatedColumnExample> {
  final AnimationHandler _animationHandler = AnimationHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Column Padding'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              transform: Matrix4.translationValues(_animationHandler.translateX, 0, 0), // Move horizontally
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.25,
                100,
                0,
                20,
              ),
              child: Text(
                _animationHandler.textContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _animationHandler.translateYBubble, 0),
              child: Transform.rotate(
                angle: _animationHandler.rotationAngle, // Apply rotation
                child: SvgPicture.asset(
                  'assets/bubble.svg',
                  height: 50,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              transform: Matrix4.translationValues(
                  _animationHandler.translateXCoach, _animationHandler.translateYCoach, 0),
              padding: EdgeInsets.fromLTRB(0, 10, 150, 0),
              child: Text(
                'Coach',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(height: 50), // Spacer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _animationHandler.animatePaddingAndRotation();
                      _animationHandler.moveRight();
                      _animationHandler.moveLeftAndUp();
                    });
                  },
                  child: Text('Animate Padding'),
                ),
                SizedBox(width: 20), // Spacer between buttons
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _animationHandler.resetAnimation();
                    });
                  }, // Reset to initial states
                  child: Text('Undo Animation'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: AnimatedColumnExample()));
