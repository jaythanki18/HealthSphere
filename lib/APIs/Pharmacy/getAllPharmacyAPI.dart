import '../../Models/Pharmacy/getAllPharmacyModel.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class PharmacyAPI {
  PharmacyAPI();

  Future<List<GetAllPharmacyModel>> fetchPharmacy(String city, String state) async {
    print('Api called');
    final uri;
    final queryParameters = {
      'city': city,
      'state': state,
    };

    uri = Uri.parse('http://192.168.166.8:3000/pharmacy/?${queryParameters.toString()}');
    print(uri.toString());

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is List) {
        List<GetAllPharmacyModel> pharmacies = jsonResponse.map((json) => GetAllPharmacyModel.fromJson(json)).toList();
      //  print('Pharmacies: $pharmacies');
        return pharmacies;
      } else {
        throw Exception('Invalid JSON response: ${response.body}');
      }
    } else {
      throw Exception('Failed to load pharmacy: ${response.statusCode}');
    }
  }
}