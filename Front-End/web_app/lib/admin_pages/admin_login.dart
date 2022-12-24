import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/admin_pages/admin_dashboard.dart';
import 'package:web_app/network_utils/network_utils.dart';

class adminLogin extends StatefulWidget {
  const adminLogin({super.key});

  @override
  State<adminLogin> createState() => _adminLoginState();
}

class _adminLoginState extends State<adminLogin> {
  @override
  final _usernameController = TextEditingController();
  final _psswController = TextEditingController();

  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Login"),
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
                    ),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      UserNetworkUtilities nh = UserNetworkUtilities();

                      var x = await nh.loginUser(
                          _usernameController.text, _psswController.text);

                      // print(x);
                      if (x == "Login Successful") {
                        html.window.localStorage['username'] =
                            _usernameController.text;
                        html.window.localStorage['loggedIn'] = "True";
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const adminDashboard()));
                      }
                    },
                    label: const Text(" Login "),
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

// Future<String> postData(var data) async {
//   var headers = {
//     'Content-Type': 'application/json',
//   };

//   final response = await http.post(
//     Uri.https("carw.vipulagrahari.repl.co", "admin/login"),
//     headers: headers,
//     body: data,
//   );

//   String message;

//   print(response.statusCode);

//   var extract = jsonDecode(response.body);

//   print(extract);
//   // Checking for a successful POST request
//   if (response.statusCode == 200) {
//     String token = extract["message"];

//     message = "Login Successful";
//   } else {
//     var extract = jsonDecode(response.body);
//     message = "Login Failed, " + extract["message"];
//   }

//   print(message);
//   return message;
// }
