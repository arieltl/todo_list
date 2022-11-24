import 'package:flutter/material.dart';
import 'package:todo_list/components/section_side_bar.dart';
import 'package:todo_list/pages/home/homepage_data.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expandable/expandable.dart';

class ProjectSideBar extends StatefulWidget {
  const ProjectSideBar({super.key});
  final nestedSideBar = const TodoSection();
  @override
  State<ProjectSideBar> createState() => _ProjectSideBarState();
}

class _ProjectSideBarState extends State<ProjectSideBar> {
  final _projectNameControler = TextEditingController();
  final projectsStream = FirebaseFirestore.instance
      .collection("Projects")
      .where('collaborators',
          arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .orderBy("dateCreated")
      .snapshots();
  final projectsReference = FirebaseFirestore.instance.collection("Projects");
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<ExpandableController> tilesControllers = [];

  void createProject() {
    if (_projectNameControler.text.trim() == "") return;

    projectsReference.add({
      "name": _projectNameControler.text,
      "ownerId": uid,
      "collaborators": [uid],
      "dateCreated": Timestamp.now(),
    });
    _projectNameControler.clear();
  }

  Widget buildTile(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return ListTile(
      onTap: () {
        final data = context.read<HomePageData>();
        data.selectedProjectid = snapshot.data!.docs[index].id;
        if (data.mode < 2) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => widget.nestedSideBar));
        }
      },
      tileColor: snapshot.data!.docs[index].id !=
              context.read<HomePageData>().selectedProjectid
          ? const Color.fromARGB(255, 167, 167, 167)
          : const Color.fromARGB(255, 236, 236, 236),
      title: Text(snapshot.data!.docs[index]["name"]),
      leading: const Icon(Icons.arrow_right),
      trailing: IconButton(
        onPressed: () {
          tilesControllers[index].expanded = !tilesControllers[index].expanded;
        },
        icon: const Icon(Icons.group_add_rounded),
      ),
    );
  }

  Widget buildBody(BuildContext context, List<String> projetos) => Scaffold(
        appBar: context.watch<HomePageData>().mode <= 1
            ? AppBar(
                title: const Text("Projects"),
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
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: TextField(
                onSubmitted: ((value) => createProject()),
                controller: _projectNameControler,
                decoration: InputDecoration(
                    labelText: "Projects",
                    icon: IconButton(
                      onPressed: createProject,
                      icon: const Icon(Icons.add),
                    )),
              ),
            ),
            Expanded(
              child: SizedBox(
                  width: 500,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: projectsStream,
                      builder: (context, snapshot) {
                        if (snapshot.data != null && snapshot.data?.docs.length !=
                            tilesControllers.length) {
                          tilesControllers = snapshot.data!.docs
                              .map((e) => ExpandableController())
                              .toList();
                        }
                        return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: snapshot.data?.docs.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final collabController = TextEditingController();

                              void addCollaborator() {
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .where("email",
                                        isEqualTo: collabController.text)
                                    .get()
                                    .then((value) {
                                  if (value.docs.isNotEmpty) {
                                    snapshot.data?.docs[index].reference
                                        .update({
                                      "collaborators": FieldValue.arrayUnion(
                                          [value.docs[0].id])
                                    });
                                  }
                                });
                              }

                              return ExpandablePanel(
                                controller: tilesControllers[index],
                                collapsed: buildTile(context, snapshot, index),
                                expanded: Column(
                                  children: [
                                    buildTile(context, snapshot, index),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextField(
                                        controller: collabController,
                                        onSubmitted: (value) =>
                                            addCollaborator(),
                                        decoration: InputDecoration(
                                            labelText: "Add Colaborators",
                                            border: const OutlineInputBorder(),
                                            icon: IconButton(
                                              onPressed: addCollaborator,
                                              icon: const Icon(Icons.add),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      })),
            )
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final data = context.watch<HomePageData>();
    if (data.mode == 2) {
      return buildBody(context, data.projects);
    }
    return Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
            builder: (ctx) => buildBody(context, data.projects)));
  }
}
