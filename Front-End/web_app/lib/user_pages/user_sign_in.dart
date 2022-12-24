import 'package:flutter/material.dart';
import 'package:web_app/main.dart';
import 'package:web_app/network_utils/network_utils.dart';

class userSignIn extends StatefulWidget {
  const userSignIn({super.key});

  @override
  State<userSignIn> createState() => _userSignInState();
}

class _userSignInState extends State<userSignIn> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();
    final _psswController = TextEditingController();
    final _psswController2 = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Sign In"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Enter your Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Username";
                        }
                        return null;
                      },
                      // onSaved: (value) => _email = value,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _psswController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Password";
                        }
                        return null;
                      },
                      // onSaved: (value) => _email = value,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _psswController2,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your Password again",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Password";
                        }
                        return null;
                      },
                      // onSaved: (value) => _email = value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      UserNetworkUtilities nh = UserNetworkUtilities();

                      var x = await nh.signUser(
                          _usernameController.text, _psswController.text);

                      // print(x);
                      if (x == "SignIn Successful") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()));
                      }
                    },
                    label: const Text(" Sign In "),
                  ),
                  const SizedBox(
                    height: 20,
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
