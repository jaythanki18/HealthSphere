import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:sgp_project_6/Models/Posts/CreatePostModel.dart';

class CreatePostAPI {
  CreatePostAPI();

  Future<CreatePostModel> register(
      String token,
      String title,
      String description,
      File post_image,
      ) async {
    var url = "http://192.168.166.8:3000/post/";
    print("Request URL: ${Uri.parse(url)}");
    debugPrint(
        "token: $token, title:$title, descr: $description, post_image:$post_image");
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add fields to the request
      request.fields['title'] = title;
      request.fields['description'] = description;

      // Attach the image file using provided function
      if (post_image != null) {
        var photostream = http.ByteStream(post_image.openRead());
        var photosize = await post_image.length();
        var photofile = http.MultipartFile(
          "post_image",
          photostream,
          photosize,
          filename: post_image.path.split('/').last,
          contentType: MediaType('image', 'jpg'), // Change content type if necessary
        );
        request.files.add(photofile);
      }

      // Send the request
      var streamedResponse = await request.send();

      // Get the response
      var response = await http.Response.fromStream(streamedResponse);

      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); // print the response body as a map
      return CreatePostModel.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception('API request error: $e');
    }
  }
}
