import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final _controller = TextEditingController();

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create"),
      actions: [
        IconButton(onPressed: (){_signOut();}, icon: const Icon(Icons.logout))
      ],),
      body: Center(child: Container(
        margin: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxHeight: 400, maxWidth: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [const BoxShadow(blurRadius: 10,color: Color.fromARGB(255, 109, 109, 109), offset: Offset(2, 2))]
        ),
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Title"
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: ElevatedButton(onPressed: (){}, child: const Text("Create")))
          ],
        ),
      )),
    );
  }
}