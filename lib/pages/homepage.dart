import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/components/subjectBar.dart';

import '../components/project_side_bar.dart';

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
        child: Row(
          children: const [
            Expanded(
              child: ProjectSideBar(),
            ),
            Expanded(
              child: SubjectBar(),
            ),
          ],
        )
      ),
    );
  }
}