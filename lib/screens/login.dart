import 'package:flutter/material.dart';
import 'package:gsu_eats/screens/signup.dart';
import 'package:gsu_eats/tools/authhandler.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'Food Reviews',
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
                      bool success = await context.read<AuthService>().signIn(
                            email: email.text,
                            password: password.text,
                          );
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login failed.'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Login",
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
