import 'package:flutter/material.dart';
import 'package:newborns_tome/widgets/hover_text.dart';

import '../utils/firebase_auth_service.dart';
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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _userAuth = FirebaseAuthService();

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

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // Perform the login verification
    if (username.isNotEmpty && password.isNotEmpty) {
      final String? userId =
          await FirebaseAuthService().loginUser(username, password);
      if (userId != null) {
        // Login successful, do something
        print('Login successful! User ID: $userId');
      } else {
        // Login failed, handle error
        print('Login failed! Invalid credentials');
      }
    } else {
      // Handle empty username or password
      print('Please enter username and password');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                CustomTextField(
                  isPassword: false,
                  label: "Username",
                  controller: _usernameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  isPassword: true,
                  label: "Password",
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 35,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _login();
                    },
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
