import 'package:flutter/material.dart';

class SubjectBar extends StatefulWidget {
  const SubjectBar({super.key});

  @override
  State<SubjectBar> createState() => _SubjectBarState();
}

class _SubjectBarState extends State<SubjectBar> {
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
      decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:[
                    Color.fromARGB(60, 176, 55, 206),
                    Color.fromARGB(60, 31, 61, 171),
                  ],
                )
              ),
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
                  tileColor: const Color.fromARGB(255, 217, 217, 217),
                  title: Text(projetos[index]),
                  leading: const Icon(Icons.arrow_right),
            ))
          ),
        )
      ]),
    );
  }
}
