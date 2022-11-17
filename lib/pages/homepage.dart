import 'package:flutter/material.dart';
import 'package:todo_list/components/project_side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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