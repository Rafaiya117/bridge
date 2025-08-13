// providers/post_provider.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tha_bridge/model/PostModel.dart';


class PostProvider with ChangeNotifier {
  List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  PostProvider() {
    loadPosts();
  }

 Future<void> loadPosts() async {
  final String jsonString = await rootBundle.loadString('assets/json/post.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  _posts = jsonData.map((e) => PostModel.fromJson(e)).toList();
  print('!-------------posts: $_posts');
  notifyListeners();
}

}
