import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/components/section_side_bar.dart';
import 'package:todo_list/model/section.dart';
import 'package:todo_list/pages/home/homepage_data.dart';
import 'package:provider/provider.dart';

class ProjectSideBar extends StatefulWidget {
  const ProjectSideBar({super.key});

  @override
  State<ProjectSideBar> createState() => _ProjectSideBarState();
}

class _ProjectSideBarState extends State<ProjectSideBar> {
  final projetNameControler = TextEditingController();
  void createProject() {
    setState(() {
      // projetos.add(projetNameControler.text);
      context.read<HomePageData>().projects.add(projetNameControler.text);
      projetNameControler.clear();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var projetos = context.watch<HomePageData>().projects;

    return Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
              builder: (ctx) => Scaffold(
                appBar: context.watch<HomePageData>().mode <= 1
                    ? AppBar(
                        title: Text("Sections"),
                      )
                    : null,
                body: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(110, 176, 55, 206),
                      Color.fromARGB(110, 31, 61, 171),
                    ],
                  )),
                  child: Column(children: [
                    TextField(
                      onSubmitted: ((value) => createProject()),
                      controller: projetNameControler,
                      decoration: InputDecoration(
                          labelText: "Projetos",
                          icon: IconButton(
                            onPressed: createProject,
                            icon: const Icon(Icons.add),
                          )),
                    ),
                    Expanded(
                      child: SizedBox(
                          width: 500,
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: projetos.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ListTile(
                                    onTap: () {
                                      final data = context.read<HomePageData>();
                                      data.selectedProject = index;
                                      if (data.mode < 2) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    SectionSideBar()));
                                      }
                                    },
                                    tileColor: index !=
                                            context
                                                .read<HomePageData>()
                                                .selectedProject
                                        ? Color.fromARGB(255, 167, 167, 167)
                                        : Color.fromARGB(255, 236, 236, 236),
                                    title: Text(projetos[index]),
                                    leading: const Icon(Icons.arrow_right),
                                  ))),
                    )
                  ]),
                ),
              ),
            ));
  }
}
