import 'package:flutter/material.dart';

class ProjectSideBar extends StatefulWidget {
  const ProjectSideBar({super.key});

  @override
  State<ProjectSideBar> createState() => _ProjectSideBarState();
}

class _ProjectSideBarState extends State<ProjectSideBar> {
  var projetos = ["eletrmoag", "modcom", "teckweb"];
  final projetNameControler = TextEditingController();
  void createProject() {
    setState(() {
      projetos.add(projetNameControler.text);
      projetNameControler.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      // color: Color.fromARGB(255, 243, 33, 177),
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
                separatorBuilder: (context, index) => const Divider(),
                itemCount: projetos.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(projetos[index]),
                      leading: const Icon(Icons.arrow_right),
                    )),
          ),
        )
      ]),
    );
  }
}
