import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sgp_project_6/Models/Posts/CommentShowModel.dart';


class ShowCommentsAPI {
  ShowCommentsAPI();

  Future<CommentShowModel> showComments(String id) async {
    var url = "http://192.168.166.8:3000/comment/";

    // Add the token to the query parameters
    url += "$id";

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    print("show comments : " + response.body);

    return CommentShowModel.fromJson(data);
  }
}