import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:sgp_project_6/Models/Pharmacy/createPharmacyModel.dart';

class CreatePharmacyAPI {
  CreatePharmacyAPI();

  Future<CreatePharmacyModel> create(
      String fullName,
      String mobileNumber,
      String email,
      String pharmacy_no,
      String pharmacist_id,
      String address,
      String city,
      String state,
      File pharmacy_photo,
      File pharmacy_certificate,
      ) async {
    var url = "http://192.168.111.8:3000/pharmacy";
    print("Request URL: ${Uri.parse(url)}");
    print(
        "$fullName, $mobileNumber, $email, $pharmacy_no, $pharmacist_id, $address, $city, $state, $pharmacy_photo, $pharmacy_certificate");
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add fields to the request
      request.fields['fullName'] = fullName;
      request.fields['mobileNumber'] = mobileNumber;
      request.fields['email'] = email;
      request.fields['pharmacy_no'] = pharmacy_no;
      request.fields['pharmacist_id'] = pharmacist_id;
      request.fields['address'] = address;
      request.fields['city'] = city;
      request.fields['state'] = state;

      // // Attach the pharmacist photo
      // if (pharmacy_photo != null) {
      //   var photostream = http.ByteStream(pharmacy_photo.openRead());
      //   var photosize = await pharmacy_photo.length();
      //   var photofile = http.MultipartFile(
      //     "pharmacy_photo",
      //     photostream,
      //     photosize,
      //     filename: pharmacy_photo.path.split('/').last,
      //   );
      //   request.files.add(photofile);
      // }
      //
      // // Attach the pharmacist certificate
      // if (pharmacy_certificate != null) {
      //   var certstream = http.ByteStream(pharmacy_certificate.openRead());
      //   var certsize = await pharmacy_certificate.length();
      //   var certfile = http.MultipartFile(
      //     "pharmacy_certificate",
      //     certstream,
      //     certsize,
      //     filename: pharmacy_certificate.path.split('/').last,
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
      return CreatePharmacyModel.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception('API request error: $e');
    }
  }
}