import 'package:flutter/material.dart';
import 'package:todo_list/ResponsivePage.dart';
import 'package:todo_list/components/subjectBar.dart';
import '../components/project_side_bar.dart';

class HomePage extends ResponsivePage {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResponsivePageState<HomePage> {
  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        children: [
          const Expanded(
            child: ProjectSideBar(),
            flex: 1,
          ),
          const Expanded(
            child: SubjectBar(),
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.amber,
              child: const Center(child: Text("Desktop"),),
            ),
          )
        ],
      )),
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        children: [
          const Expanded(
            child: SubjectBar(),
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.red,
              child: const Center(child: Text("Tablet"),),
            ),
          )
        ],
      )),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Container(color: Colors.blue,
      child: const Center(child: Text("Mobile"),),
    );
  }
}
