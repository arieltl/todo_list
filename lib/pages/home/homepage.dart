import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/ResponsivePage.dart';
import 'package:todo_list/components/section_content.dart';
import 'package:todo_list/components/section_side_bar.dart';
import 'package:todo_list/pages/home/homepage_data.dart';
import '../../components/project_side_bar.dart';

class HomePage extends ResponsivePage {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResponsivePageState<HomePage> {
  final SectionSideBar sectionSideBar = SectionSideBar();
  final data = HomePageData();
  Widget buildScaffold(BuildContext context, {required Widget body}) =>
      Scaffold(
        appBar: AppBar(title: Text("Todo")),
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
          const Expanded(
            child: ProjectSideBar(),
            flex: 1,
          ),
          Expanded(
            child: sectionSideBar,
            flex: 1,
          ),
          Expanded(
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
          const Expanded(
            child: ProjectSideBar(),
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

    return buildScaffold(context, body: ProjectSideBar());
  }
}
