import 'package:flutter/material.dart';
import 'package:todo_list/components/section_content.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/home/homepage_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoSection extends StatefulWidget {
  const TodoSection({super.key});
  @override
  State<TodoSection> createState() => _TodoSectionState();
}

class _TodoSectionState extends State<TodoSection> {
  final _sectionNameFieldControler = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final data = context.watch<HomePageData>();

    if (data.selectedProjectid == "") {
      return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(60, 176, 55, 206),
            Color.fromARGB(60, 31, 61, 171),
          ],
        )),
        child: Center(
          child: Text("Please select a project"),
        ),
      );
    }
    final sections = data.sections;
    int selected = data.selectedSection;
    final project = data.selectedProjectid == "" ? "a" : data.selectedProjectid;

    final sectionStream = FirebaseFirestore.instance
        .collection("Projects")
        .doc(project)
        .collection("Sections")
        .snapshots();
    final sectionReference = FirebaseFirestore.instance
        .collection("Projects")
        .doc(project)
        .collection("Sections");
    void createProject() {
      if (_sectionNameFieldControler.text.trim() == "") return;
      if (data.selectedProjectid == "") return;
      sectionReference.add({
        "name": _sectionNameFieldControler.text,
      });
      _sectionNameFieldControler.clear();
    }

    return Scaffold(
      appBar: context.watch<HomePageData>().mode <= 1
          ? AppBar(
              title: const Text("Sections"),
            )
          : null,
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(60, 176, 55, 206),
            Color.fromARGB(60, 31, 61, 171),
          ],
        )),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextField(
              onSubmitted: ((value) => createProject()),
              controller: _sectionNameFieldControler,
              decoration: InputDecoration(
                  labelText: "Sections",
                  icon: IconButton(
                    onPressed: createProject,
                    icon: const Icon(Icons.add),
                  )),
            ),
          ),
          Expanded(
            child: SizedBox(
                width: 500,
                child: project == ""
                    ? Container()
                    : StreamBuilder<QuerySnapshot>(
                        stream: sectionStream,
                        builder: (context, snapshot) {
                          return ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: snapshot.data?.docs.length ?? 0,
                              itemBuilder: (context, index) {
                                final doc = snapshot.data!.docs[index];
                                return (ListTile(
                                  tileColor: doc.id != data.selectedSectionid
                                      ? const Color.fromARGB(255, 209, 209, 209)
                                      : const Color.fromARGB(
                                          245, 232, 232, 232),
                                  onTap: () {
                                    final data = Provider.of<HomePageData>(
                                        context,
                                        listen: false);
                                    data.selectedSectionid = doc.id;
                                    if (data.mode == 0) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SectionContent()));
                                    }
                                  },
                                  title: Text(doc["name"]),
                                  leading: Icon(
                                    Icons.arrow_right,
                                    color: doc.id != data.selectedSectionid
                                        ? IconTheme.of(context).color
                                        : Colors.white38,
                                  ),
                                ));
                              });
                        })),
          )
        ]),
      ),
    );
  }
}
