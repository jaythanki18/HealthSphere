import 'dart:convert';
import 'dart:io';

import 'package:sgp_project_6/Models/User/userRegisterModel.dart';
import 'package:http/http.dart' as http;

class UserRegisterAPI {
  UserRegisterAPI();

  Future<UserRegisterModel> register(
      String fullName,
      String mobileNumber,
      String email,
      String medicalStudent,
      String password,
      File userPhoto,
      ) async {
    var url = "http://192.168.192.8:3000/user";
    print("Request URL: ${Uri.parse(url)}");
    print("$fullName $mobileNumber $email $medicalStudent $password $userPhoto");
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add fields to the request
      request.fields['fullName'] = fullName;
      request.fields['mobileNumber'] = mobileNumber;
      request.fields['email'] = email;
      request.fields['medical_student'] = medicalStudent;
      request.fields['password'] = password;

      // Attach the image file
      if (userPhoto != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'user_photo',
            userPhoto.path,
          ),
        );
      }
      // Send the request
      var streamedResponse = await request.send();

      // Get the response
      var response = await http.Response.fromStream(streamedResponse);

      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); // print the response body as a map
      return UserRegisterModel.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception('API request error: $e');
    }
  }
}
