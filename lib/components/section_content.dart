import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/home/homepage_data.dart';

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
    return Scaffold(
      body: Container(
        color: mode == 2
            ? Colors.amber
            : mode == 1
                ? Colors.blue
                : Colors.red,
        child: Center(
          child: Text(
              "Section ${data.sections[selected]}"),
        ),
      ),
    );
  }
}
