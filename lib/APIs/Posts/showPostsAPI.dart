import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sgp_project_6/Models/Posts/ShowPostsModel.dart';

class ShowPostsAPI {
  ShowPostsAPI();

  Future<ShowPostsModel> showPosts(String token) async {
    var url = "http://192.168.166.8:3000/post/";

    // Add the token to the query parameters
    url += "?Authorization=$token";

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    print("show posts : " + response.body);

    return ShowPostsModel.fromJson(data);
  }
}