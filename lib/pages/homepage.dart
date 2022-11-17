import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final _controller = TextEditingController();

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.passthrough,
          children: const <Widget>[
            SizedBox(
              width: 500,
              child: ProjectSideBar(),
            )
          ],
        ),
      ),
    );
  }
}