import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:web_app/admin_pages/admin_login.dart';
import 'package:web_app/user_pages/user_dashboard.dart';
import 'package:web_app/user_pages/user_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_utils/network_utils.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'User Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Future _getLogin(String user, String pssw) async {

  // }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _usernameController = TextEditingController();
    final _psswController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                          return "Please enter your Username";
                        }
                        return null;
                      },
                      // onSaved: (value) => _email = value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      UserNetworkUtilities nh = UserNetworkUtilities();

                      var x = await nh.loginUser(
                          _usernameController.text, _psswController.text);

                      // print(x);
                      if (x == "Login Successful") {
                        // prefs.setString("username", _usernameController.text);
                        // prefs.setBool("isUserLoggedIn", true);

                        html.window.localStorage['username'] =
                            _usernameController.text;
                        html.window.localStorage['loggedIn'] = "True";
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()));
                        // Navigator.push<void>(
                        //   context,
                        //   MaterialPageRoute<void>(
                        //       builder: (BuildContext context) =>
                        //           const ),
                        // );
                      }
                    },
                    label: const Text(" Login "),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const userSignIn()),
                      );
                    },
                    label: const Text(" Sign In "),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const adminLogin()),
          );
        },
        shape: const RoundedRectangleBorder(),
        tooltip: 'Admin',
        child: const Icon(Icons.admin_panel_settings),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future _getlog() {
  UserNetworkUtilities un = UserNetworkUtilities();

  var x = un.loginUser("admin", "abcd");

  return x;
}
