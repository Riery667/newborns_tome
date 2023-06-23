import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newborns_tome/widgets/background_animation.dart';
import 'package:newborns_tome/widgets/intro_image_animation.dart';
import 'package:newborns_tome/widgets/text_animation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> text = ["IDEAL", "GREEK", "BEAUTY"];
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final leftPadding = size.width * 0.025;
          final topPadding = size.height * 0.075;
          return Stack(
            children: [
              const BackgroundAnimation(
                image: "assets/background.png",
              ),
              const IntroImageAnimation(
                image: "assets/virgem_maria.png",
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  leftPadding,
                  topPadding,
                  leftPadding,
                  topPadding,
                ),
                child: const TextAnimation(),
              ),
              Center(
                child: ClipPath(
                  clipper: InvertedRect(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 15.0,
                      sigmaY: 15.0,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class InvertedRect extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    print(size);
    return Path()
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..addRect(Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width * 0.95,
          height: size.height * 0.85))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BallMoving extends StatefulWidget {
  const BallMoving({Key? key}) : super(key: key);

  @override
  State<BallMoving> createState() => _BallMovingState();
}

class _BallMovingState extends State<BallMoving>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double controllerY = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween(begin: -1.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Align(
          alignment: Alignment(_animation.value, controllerY),
          child: GestureDetector(
            onTap: () {
              // Handle onTap if needed
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
