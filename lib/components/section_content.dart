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
    int mode = data.mode;
    int selected = data.selectedSection;
    final todoReference = FirebaseFirestore.instance.collection("Todos");
    final todoStream = FirebaseFirestore.instance.collection("Todos").snapshots();
    final text

    void createTodo(){
      todoReference.add({
        "completed": false,
        "text": 
      })
    }

    return Scaffold(
      body: Container(
        color: mode == 2
            ? Colors.amber
            : mode == 1
                ? Colors.blue
                : Colors.red,
        child: Center(
          TextField(
            onSubmitted: ((value) => createTodo()),
          )
      ),
    );
  }
}