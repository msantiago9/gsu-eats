import 'package:flutter/material.dart';
import 'package:gsu_eats/tools/authhandler.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Image.asset(
                "assets/gsulogo.png",
                height: 150,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Kurale',
                  fontSize: 20,
                ),
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "email",
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
                      onPressed: () async {
                        bool success = await context.read<AuthService>().signUp(
                              email: email.text,
                              password: password.text,
                            );
                        if (success) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sign up failed.'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Create Account",
                      ),
                    ),
                  ),
                  ElevatedButton(
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
    );
  }
}
