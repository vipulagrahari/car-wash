import 'dart:convert';

import 'package:http/http.dart' as http;

class UserNetworkUtilities {
  // Utility function to login the user
  Future<String> loginUser(
    String user,
    String password,
  ) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = jsonEncode({
      "user_id": user,
      "password": password,
    });

    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.https("carw.vipulagrahari.repl.co", "user/login"),
      headers: headers,
      body: body,
    );

    String message;

    print(response.statusCode);
    var extract = jsonDecode(response.body);
    print(extract);
    // Checking for a successful POST request
    if (response.statusCode == 200) {
      String token = extract["message"];

      message = "Login Successful";
    } else {
      var extract = jsonDecode(response.body);
      message = "Login Failed, " + extract["message"];
    }

    print(message);
    return message;
  }

  Future<String> signUser(
    String user,
    String password,
  ) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = jsonEncode({
      "user_id": user,
      "password": password,
    });

    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.https("carw.vipulagrahari.repl.co", "user/signIn"),
      headers: headers,
      body: body,
    );

    String message;

    print(response.statusCode);
    var extract = jsonDecode(response.body);
    print(extract);
    // Checking for a successful POST request
    if (response.statusCode == 200) {
      String token = extract["message"];

      message = "Login Successful";
    } else {
      var extract = jsonDecode(response.body);
      message = "Login Failed, " + extract["message"];
    }

    print(message);
    return message;
  }

  Future<String> loginAdmin(
    String user,
    String password,
  ) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = jsonEncode({
      "user_id": user,
      "password": password,
    });

    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.https("carw.vipulagrahari.repl.co", "admin/login"),
      headers: headers,
      body: body,
    );

    String message;

    print(response.statusCode);
    var extract = jsonDecode(response.body);
    print(extract);
    // Checking for a successful POST request
    if (response.statusCode == 200) {
      String token = extract["message"];

      message = "Login Successful";
    } else {
      var extract = jsonDecode(response.body);
      message = "Login Failed, " + extract["message"];
    }

    print(message);
    return message;
  }

  Future<String> getSearch(String place) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
        Uri.https("carw.vipulagrahari.repl.co", "user/search/$place"),
        headers: headers);

    String message;

    print(response.statusCode);

    // Checking for a successful GET request
    if (response.statusCode == 200) {
      var extract = jsonDecode(response.body);
      message = extract["message"];
    } else {
      var extract = jsonDecode(response.body);
      message = "Request Failed, " + extract["message"];
    }

    print(message);
    return message;
  }

  void addLocation(data) async {
    var headers = {'Content-Type': 'application/json'};

    final response = await http.post(
        Uri.https("carw.vipulagrahari.repl.co", "user/addLocation"),
        headers: headers);

    if (response.statusCode == 200) {
      var extract = jsonDecode(response.body);
      print(extract);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void addService(data) async {
    var headers = {'Content-Type': 'application/json'};

    final response = await http.post(
        Uri.https("carw.vipulagrahari.repl.co", "user/addService"),
        headers: headers);

    if (response.statusCode == 200) {
      var extract = jsonDecode(response.body);
      print(extract);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
