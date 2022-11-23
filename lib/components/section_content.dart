import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/home/homepage_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SectionContent extends StatefulWidget {
  const SectionContent({super.key});

  @override
  State<SectionContent> createState() => _SectionContentState();
}

class _SectionContentState extends State<SectionContent> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<HomePageData>();
    if (data.selectedProjectid == "" || data.selectedSectionid == "") {
      return const Center(
        child: Text("Select a project and section"),
      );
    }

    final todoReference = FirebaseFirestore.instance
        .collection("Projects")
        .doc(data.selectedProjectid)
        .collection("Sections")
        .doc(data.selectedSectionid)
        .collection("Todos");
    final todoStream = FirebaseFirestore.instance
        .collection("Projects")
        .doc(data.selectedProjectid)
        .collection("Sections")
        .doc(data.selectedSectionid)
        .collection("Todos")
        .orderBy("completed")
        .snapshots();
    final inputController = TextEditingController();

    void createTodo() {
      final text = inputController.text;
      final words = text.split(" ");
      final tags = words.where((word) => word.startsWith("#")).toList();
      todoReference.add({
        "completed": false,
        "text": text,
        "dateCreated": Timestamp.now(),
        "tags": tags,
      });

      inputController.clear();
    }

    return Scaffold(
        body: Container(
            color: const Color.fromARGB(51, 209, 209, 209),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 40, right: 40, bottom: 20),
                  child: TextField(
                    onSubmitted: ((value) => createTodo()),
                    controller: inputController,
                    decoration: InputDecoration(
                        labelText: "Insert your task",
                        icon: IconButton(
                          onPressed: createTodo,
                          icon: const Icon(Icons.add),
                        )),
                  ),
                ),
                SizedBox(
                  width: 500,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: todoStream,
                    builder: ((context, snapshot) {
                      return ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: snapshot.data?.docs.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final doc = snapshot.data!.docs[index];
                            return ListTile(
                              title: RichText(
                                text: TextSpan(
                                  text: "",
                                  children: List<InlineSpan>.from(doc["text"].split(" ").map(
                                        (word) => TextSpan(
                                          text: word + " ",
                                          style: TextStyle(
                                            color: word.startsWith("#")
                                                ? Colors.blue
                                                : Colors.black,
                                            fontWeight: word.startsWith("#")
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ).toList()),
                                
                                ),
                              ),
                              trailing: Checkbox(
                                value: doc["completed"],
                                onChanged: (value) {
                                  doc.reference.update({"completed": value});
                                },
                              ),
                            );
                          });
                    }),
                  ),
                )
              ],
            )));
  }
}
