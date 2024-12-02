import 'package:flutter/material.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Product'),
      ),
      body: const Center(
        child: Text('Hello, Flutter!'),
      ),
    );
  }
}
