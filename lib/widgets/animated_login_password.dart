import 'package:flutter/material.dart';
import 'package:newborns_tome/widgets/hover_text.dart';

import 'custom_text_field.dart';

class AnimatedLoginPassword extends StatefulWidget {
  const AnimatedLoginPassword({super.key});

  @override
  State<AnimatedLoginPassword> createState() => _AnimatedLoginPasswordState();
}

class _AnimatedLoginPasswordState extends State<AnimatedLoginPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    const int duration = 1;
    const double begin = 0;
    const double end = 1;
    _controller = AnimationController(
        duration: const Duration(
          seconds: duration,
        ),
        vsync: this);

    _opacityAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late String name;
    late String password;
    return RepaintBoundary(
      child: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: SizedBox(
            height: 250,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextField(
                  isPassword: false,
                  label: "Username",
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomTextField(
                  isPassword: true,
                  label: "Password",
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 35,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  child: const HoverText(
                    text: "New? Register now!",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
