import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newborns_tome/widgets/animated_background.dart';
import 'package:newborns_tome/widgets/animated_line.dart';
import 'package:newborns_tome/widgets/animated_login_password.dart';
import 'package:newborns_tome/widgets/animated_text.dart';

import '../utils/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<Alignment> _animationImage;
  late Animation<Offset> _animationTextBottom;
  late Animation<Offset> _animationTextTop;

  final _isAnimationComplete = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // _animationImage = Tween<Alignment>(
    //   begin: const Alignment(0.5, 0),
    //   end: Alignment.centerRight,
    // ).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: const Interval(
    //       0.0,
    //       0.8,
    //       curve: Curves.easeInOut,
    //     ),
    //   ),
    // );

    _animationTextBottom = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.5,
          0.8,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationTextTop = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.5,
          0.8,
          curve: Curves.easeInOut,
        ),
      ),
    );

    //TODO: CRAZYYY
    _controller.forward().whenComplete(() async {
      await Future.delayed(const Duration(seconds: 2));

      _controller.reverse().whenComplete(() {
        _isAnimationComplete.value = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(
            image: "assets/clouds.jpg",
          ),
          // AnimationIntroImage(
          //   image: "assets/maria_jesus.png",
          //   controller: _controller,
          //   animation: _animationImage,
          // ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: AnimatedText(
                    controller: _controller,
                    animation: _animationTextBottom,
                    txt: "THE",
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedLine(
                    controller: _controller,
                    middleScreenSize: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                AnimatedText(
                  controller: _controller,
                  animation: _animationTextTop,
                  txt: "NEWSBORN`S",
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedLine(
                    controller: _controller,
                    middleScreenSize: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                AnimatedText(
                  controller: _controller,
                  animation: _animationTextTop,
                  txt: "TOME",
                ),
              ],
            ),
          ),
          Center(
            child: ClipPath(
              clipper: InvertedRect(),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _isAnimationComplete,
            builder: (context, child) {
              if (_isAnimationComplete.value) {
                return child!;
              }
              return const SizedBox.shrink();
            },
            child: const AnimatedLoginPassword(),
          ),
        ],
      ),
    );
  }
}

class InvertedRect extends CustomClipper<Path> {
  @override
  getClip(Size size) {
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
