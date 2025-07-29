import 'package:flutter/material.dart';
import '../controller/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  Widget build(context, RegisterController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }

  @override
  State<RegisterView> createState() => RegisterController();
}
