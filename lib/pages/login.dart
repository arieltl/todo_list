import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _login = TextEditingController();
  final _senha = TextEditingController();
  final CollectionReference _users = FirebaseFirestore.instance.collection("Users");

   _createUser() {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: _login.text.trim(), password: _senha.text.trim()).then((user) => {
      _users.doc(user.user!.uid).set({
        "email":_login.text.trim(),
        "username":_login.text.trim()
      })
    });
  } 

  Future _loginuser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _login.text.trim(),
      password: _senha.text.trim(),
    );
  }

  Future _resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _login.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(200, 176, 55, 206),
                  Color.fromARGB(200, 31, 61, 171),
                ],
              )),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                margin: const EdgeInsets.all(20),
                constraints:
                    const BoxConstraints(maxHeight: 414, maxWidth: 500),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10,
                          color: Color.fromARGB(255, 109, 109, 109),
                          offset: Offset(2, 2))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: _login,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Email"),
                    ),
                    TextField(
                      controller: _senha,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Senha"),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 120,
                            child: ElevatedButton(
                              onPressed: () {
                                _loginuser();
                              },
                              child: const Text("Login"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 120,
                            child: ElevatedButton(
                                onPressed: () {
                                  _createUser();
                                },
                                child: const Text("Sign Up")),
                          )
                        ]),
                    SizedBox(
                        height: 30,
                        width: 200,
                        child: TextButton(
                          onPressed: () {
                            _resetPassword();
                          },
                          child: const Text("Esqueci a Senha"),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
