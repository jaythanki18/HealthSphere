import 'dart:convert';
import 'package:sgp_project_6/Models/User/userLoginModel.dart';
import 'package:http/http.dart' as http;

class UserLoginAPI {
  UserLoginAPI();

  Future<UserLoginModel> userLogin(email, password, role) async {
    var url = "http://192.168.166.8:3000/auth/login";
    print("Request URL: ${Uri.parse(url)}");
    print("$email  $password $role");
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'password': password,
          'role': role,
        },
      );

      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
     // print(data); // print the response body as a map
      return UserLoginModel.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception('API request error: $e');
    }
  }
}