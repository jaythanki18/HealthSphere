import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'package:sgp_project_6/Models/Doctor/doctorRegisterModel.dart';

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
    var url = "http://192.168.111.8:3000/doctor";
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
        var photostream = http.ByteStream(doctorPhoto.openRead());
        var photosize = await doctorPhoto.length();
        var photofile = http.MultipartFile(
          "doctor_photo",
          photostream,
          photosize,
          filename: doctorPhoto.path.split('/').last,
          contentType: MediaType('image', 'jpeg'), // Change content type if necessary
        );
        request.files.add(photofile);
      }

      // Attach the certificate file
      if (doctorCertificate != null) {
        var certstream = http.ByteStream(doctorCertificate.openRead());
        var certsize = await doctorCertificate.length();
        var certfile = http.MultipartFile(
          "doctor_certificate",
          certstream,
          certsize,
          filename: doctorCertificate.path.split('/').last,
          contentType: MediaType('application', 'pdf'), // Change content type if necessary
        );
        request.files.add(certfile);
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
