import 'package:flutter/material.dart';
import 'package:todo_list/components/project_side_bar.dart';
import 'package:todo_list/components/section_content.dart';
import 'package:todo_list/pages/home/homepage.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/home/homepage_data.dart';

class SectionSideBar extends StatefulWidget {
  const SectionSideBar({super.key});
  @override
  State<SectionSideBar> createState() => _SectionSideBarState();
}

class _SectionSideBarState extends State<SectionSideBar> {
  final _sectionNameFieldControler = TextEditingController();

  void createProject() {
    setState(() {
      context
          .read<HomePageData>()
          .sections
          .add(_sectionNameFieldControler.text);
      _sectionNameFieldControler.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sections = context.watch<HomePageData>().sections;
    int selected = context.watch<HomePageData>().selectedSection;

    print(context.watch<HomePageData>().mode);
    return Scaffold(
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
            Color.fromARGB(60, 176, 55, 206),
            Color.fromARGB(60, 31, 61, 171),
          ],
        )),
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
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
                child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: sections.length,
                    itemBuilder: (context, index) => ListTile(
                          tileColor: index != selected
                              ? Color.fromARGB(255, 209, 209, 209)
                              : Color.fromARGB(245, 232, 232, 232),
                          onTap: () {
                            final data = Provider.of<HomePageData>(context, listen: false);
                            data.selectedSection = index;
                            if (data.mode == 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SectionContent()));
                            }
                          },
                          title: Text(sections[index]),
                          leading: Icon(
                            Icons.arrow_right,
                            color: index != selected
                                ? IconTheme.of(context).color
                                : Colors.white38,
                          ),
                        ))),
          )
        ]),
      ),
    );
  }
}
