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
    // final todoStream2 = FirebaseFirestore.instance.collectionGroup("Todos").where("tags",arrayContains: tag).where(field)

    final inputController = TextEditingController();

    void createTodo() {
      final text = inputController.text;
      final words = text.split(" ");
      final tags = words.where((word) => word.startsWith("#")).toList();
      List<String> importances = words
          .where((word) =>
              word.startsWith("!") && word.toLowerCase().endsWith("important"))
          .toList();
      final importance = importances
          .map((e) => e.length - e.replaceAll("!", " ").trimLeft().length).followedBy([0])
          .reduce((a, b) => a > b ? a : b);

      todoReference.add({
        "completed": false,
        "text": text,
        "dateCreated": Timestamp.now(),
        "tags": tags,
        "importance": importance,
      });

      inputController.clear();
    }

    return Scaffold(
       appBar: context.watch<HomePageData>().mode <= 1
          ? AppBar(
              title: const Text("ToDos"),
            )
          : null,
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
                            final int importance = doc["importance"] ?? 0;
                            String lowerText =
                                doc["text"].toString().toLowerCase();
                            return ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              child: Dismissible(
                                key: ValueKey<String>(doc.id),
                                background: Container(
                                  color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Icon(Icons.delete),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                    ],
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) =>
                                    doc.reference.delete(),
                                child: ListTile(
                                  // tileColor: lowerText.contains("!!!important")
                                  //     ? Color.fromARGB(240, 180, 4, 4)
                                  //     : lowerText.contains("!!important")
                                  //         ? Color.fromARGB(200, 180, 4, 4)
                                  //         : lowerText.contains("!important")
                                  //             ? Color.fromARGB(150, 180, 4, 4)
                                  //             : Colors.transparent,
                                  tileColor: importance >=3
                                      ? Color.fromARGB(240, 210, 20, 4)
                                      : importance==2
                                          ? Color.fromARGB(210, 210, 20, 4)
                                          : importance == 1
                                              ? Color.fromARGB(150, 210, 20, 4)
                                              : Colors.transparent,
                                  title: RichText(
                                    text: TextSpan(
                                      text: "",
                                      children:
                                          List<InlineSpan>.from(doc["text"]
                                              .split(" ")
                                              .map(
                                                (word) => TextSpan(
                                                  text: word + " ",
                                                  style: TextStyle(
                                                      color: word.startsWith(
                                                                  "!") &&
                                                              word
                                                                  .toLowerCase()
                                                                  .endsWith(
                                                                      "important")
                                                          ? Colors.yellow
                                                          : word.startsWith("#")
                                                              ? Colors.blue
                                                              : Colors.black,
                                                      fontWeight: word
                                                                  .startsWith(
                                                                      "!") &&
                                                              word
                                                                  .toLowerCase()
                                                                  .endsWith(
                                                                      "important")
                                                          ? FontWeight.bold
                                                          : word.startsWith("#")
                                                              ? FontWeight.bold
                                                              : FontWeight
                                                                  .normal,
                                                      fontSize: word.startsWith(
                                                                  "!") &&
                                                              word
                                                                  .toLowerCase()
                                                                  .endsWith(
                                                                      "important")
                                                          ? 16
                                                          : 15),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                  ),
                                  trailing: Checkbox(
                                    value: doc["completed"],
                                    onChanged: (value) {
                                      doc.reference
                                          .update({"completed": value});
                                    },
                                  ),
                                ),
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
