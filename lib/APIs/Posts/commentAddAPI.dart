import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../Models/Posts/CommentAddModel.dart';

class CommentAddAPI {
  CommentAddAPI();

  Future<CommentAddModel> addComment(token,postId,description) async {
    var url = "http://192.168.166.8:3000/comment/";
    debugPrint("Request URL: ${Uri.parse(url)}");
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': '$token', // Include the token in the Authorization header
        },
        body: {
          'postId': postId,
          'description': description,
        },
      );
      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
       print(data); // print the response body as a map
      return CommentAddModel.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception('API request error: $e');
    }
  }
}