import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'package:sgp_project_6/Models/Pharmacist/pharmacistRegisterModel.dart';

class PharmacistRegisterAPI {
  PharmacistRegisterAPI();

  Future<PharmacistRegisterModel> register(
      String fullName,
      String mobileNumber,
      String email,
      String liscence,
      String password,
      File pharmacistPhoto,
      File pharmacistCertificate,
      ) async {
    var url = "http://192.168.166.8:3000/pharmacist";
    print("Request URL: ${Uri.parse(url)}");
    print("$fullName $mobileNumber $email $password $pharmacistPhoto");
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add fields to the request
      request.fields['fullName'] = fullName;
      request.fields['mobileNumber'] = mobileNumber;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['pharmacist_liscence'] = liscence;

      // // Attach the pharmacist photo
      // if (pharmacistPhoto != null) {
      //   var photostream = http.ByteStream(pharmacistPhoto.openRead());
      //   var photosize = await pharmacistPhoto.length();
      //   var photofile = http.MultipartFile(
      //     "pharmacist_photo",
      //     photostream,
      //     photosize,
      //     filename: pharmacistPhoto.path.split('/').last,
      //   );
      //   request.files.add(photofile);
      // }
      //
      // // Attach the pharmacist certificate
      // if (pharmacistCertificate != null) {
      //   var certstream = http.ByteStream(pharmacistCertificate.openRead());
      //   var certsize = await pharmacistCertificate.length();
      //   var certfile = http.MultipartFile(
      //     "pharmacist_certificate",
      //     certstream,
      //     certsize,
      //     filename: pharmacistCertificate.path.split('/').last,
      //   );
      //   request.files.add(certfile);
      // }

      // Send the request
      var streamedResponse = await request.send();

      // Get the response
      var response = await http.Response.fromStream(streamedResponse);

      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); // print the response body as a map
      return PharmacistRegisterModel.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception('API request error: $e');
    }
  }
}
