import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/ResponsivePage.dart';
import 'package:todo_list/components/section_content.dart';
import 'package:todo_list/components/section_side_bar.dart';
import 'package:todo_list/pages/home/homepage_data.dart';
import '../../components/project_side_bar.dart';

class HomePage extends ResponsivePage {
  const HomePage({super.key});
  final mobilePage = const ProjectSideBar();
  final desktopProj = const ProjectSideBar();
  final tabletProj = const ProjectSideBar();
  final desktopSec = const TodoSection();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResponsivePageState<HomePage> {
  final data = HomePageData();
  Widget buildScaffold(BuildContext context, {required Widget body}) =>
      Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
          actions: [
            IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout),
            )
          ],
          ),
        body: ChangeNotifierProvider(
          create: (context) => data,
          child: body,
        ),
      );
  @override
  Widget buildDesktop(BuildContext context) {
    
    data.setMode(2);
    return buildScaffold(
      context,
      body: Center(
          child: Row(
        children: [
           Expanded(
            flex: 1,
            child: widget.desktopProj,
          ),
          Expanded(
            flex: 1,
            child: widget.desktopSec,
          ),
          const Expanded(
            flex: 3,
            child: SectionContent(),
          )
        ],
      )),
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    data.setMode(1);

    return buildScaffold(
      context,
      body: Center(
          child: Row(
        children: [
           Expanded(
            child: widget.tabletProj,
            flex: 2,
          ),
          Expanded(flex: 4, child: SectionContent())
        ],
      )),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    data.setMode(0);

    return buildScaffold(context, body: widget.mobilePage);
  }
}
