import 'package:flutter/material.dart';
import 'package:gsu_eats/tools/authhandler.dart';
import 'package:provider/provider.dart';
import 'package:gsu_eats/tools/dbhandler.dart';

class SignUp extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Image.asset(
                "assets/GSUEatsT.png",
                height: 265,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "E-mail",
              ),
              autocorrect: false,
            ),
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
              autocorrect: false,
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
              autocorrect: false,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        String success =
                            await context.read<AuthService>().signUp(
                                  email: email.text,
                                  password: password.text,
                                );
                        if (success == "error") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sign up failed.'),
                            ),
                          );
                        } else {
                          await DBServ().addUser(name.text, success, context);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Create Account",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Return",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
