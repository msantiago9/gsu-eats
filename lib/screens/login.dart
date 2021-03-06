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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg1.jpg"),
          fit: BoxFit.cover,
          //opacity: 0.85, error idk why
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white.withOpacity(.95),
            ),
            constraints: const BoxConstraints(
              minHeight: 450,
              maxHeight: 650,
            ),
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: "Email",
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
                            await context
                                .read<AuthService>()
                                .signIn(email.text, password.text, context);
                          },
                          child: const Text(
                            "Login",
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
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
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Image.asset(
                    "assets/gsulogo.png",
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
