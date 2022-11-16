import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:[
                Color.fromARGB(200, 176, 55, 206),
                Color.fromARGB(200, 31, 61, 171),
              ],
            )
          ),
        ),
      ),
    );
  }
}