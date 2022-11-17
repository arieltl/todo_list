import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _login = TextEditingController();
  final _senha = TextEditingController();

  Future _createUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _login.text.trim(), password: _senha.text.trim());
  }

  Future _loginuser() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _login.text.trim(),
      password: _senha.text.trim(),
    );
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
                  colors:[
                    Color.fromARGB(200, 176, 55, 206),
                    Color.fromARGB(200, 31, 61, 171),
                  ],
                )
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                margin: const EdgeInsets.all(20),
                constraints: const BoxConstraints(maxHeight: 414,maxWidth: 500),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(blurRadius: 10, color: Color.fromARGB(255, 109, 109, 109), offset: Offset(2, 2))]
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: _login,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email"
                    ),
                  ),
                  TextField(
                    controller: _senha,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Senha"
                    ),
                
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: ElevatedButton(onPressed: (){_loginuser();}, child: const Text("Login")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: ElevatedButton(onPressed: (){_createUser();}, child: const Text("Sign Up")),
                      )
                    ]
                  )
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