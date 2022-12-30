import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<void> makeRequest() async {
//   String url = "https://carw.vipulagrahari.repl.co/user/login";

//   // Convert the string to a Uri object
//   Uri uri = Uri.parse(url);

//   Map<String, String> data = {
//     "user_id": "test",
//     "password": "abcd",
//   };

//   Map<String, String> headers = {
//     "Access-Control-Allow-Origin": "*",
//   };

//   http.Response response =
//       await http.post(uri, body: json.encode(data), headers: headers);

//   print(response.body);
// }

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
      'Access-Control-Allow-Origin': '*',
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
      // Saving token to Shared Preferences and setting isUserLoggedIn to true to keep the user signed in.

      String token = extract["message"];
      // prefs.setString("token", token);
      // prefs.setBool("isUserLoggedIn", true);
      message = "Login Successful";
    } else {
      var extract = jsonDecode(response.body);
      message = "Login Failed, " + extract["message"];
    }

    print(message);
    return message;
  }
}

void main() {
  // makeRequest();

  UserNetworkUtilities un = UserNetworkUtilities();

  var x = un.loginUser("admin", "abcd");
}
