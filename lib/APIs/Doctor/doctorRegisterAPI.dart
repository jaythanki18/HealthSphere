import 'dart:convert';
import 'dart:io';

import 'package:sgp_project_6/Models/Doctor/doctorRegisterModel.dart';
import 'package:http/http.dart' as http;

class DoctorRegisterAPI {
  DoctorRegisterAPI();

  Future<DoctorRegisterModel> register(
      String fullName,
      String mobileNumber,
      String email,
      String doctorId,
      File doctorPhoto,
      File doctorCertificate,
      String password,
      ) async {
    var url = "http://192.168.75.8:3000/doctor";
    print("Request URL: ${Uri.parse(url)}");
    print(
        "$fullName $mobileNumber $email $doctorId $doctorPhoto $doctorCertificate $password");

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add fields to the request
      request.fields['fullName'] = fullName;
      request.fields['mobileNumber'] = mobileNumber;
      request.fields['email'] = email;
      request.fields['doctor_id'] = doctorId;
      request.fields['password'] = password;

      // Attach the image file
      if (doctorPhoto != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'doctor_photo',
            doctorPhoto.path,
          ),
        );
      }

      // Attach the certificate file
      if (doctorCertificate != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'doctor_certificate',
            doctorCertificate.path,
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
      return DoctorRegisterModel.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception('API request error: $e');
    }
  }
}
