import 'package:firebase_auth/firebase_auth.dart';
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
    _signOut();
    setState(() {
      projetos.add(projetNameControler.text);
      projetNameControler.clear();
    });
  }

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
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
