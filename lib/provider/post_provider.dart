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

//  Future<void> loadPosts() async {
//   final String jsonString = await rootBundle.loadString('assets/json/post.json');
//   final List<dynamic> jsonData = json.decode(jsonString);
//   _posts = jsonData.map((e) => PostModel.fromJson(e)).toList();
//   print('!-------------posts: $_posts');
//   notifyListeners();
// }

Future<void> loadPosts() async {
  final String postString = await rootBundle.loadString('assets/json/post.json');
  final List<dynamic> postData = json.decode(postString);
  _posts = postData.map((e) => PostModel.fromJson(e)).toList();

  final String commentString = await rootBundle.loadString('assets/json/comments.json');
  final Map<String, dynamic> commentData = json.decode(commentString);

  // Merge comments into each post
  for (var post in _posts) {
    final commentsJson = commentData[post.id] as List<dynamic>? ?? [];
    post.comments.addAll(commentsJson.map((c) => Comment.fromJson(c)));
  }

  notifyListeners();
}


void addCommentToPost(PostModel post, Comment comment) {
  final postIndex = _posts.indexOf(post);
  if (postIndex != -1) {
    _posts[postIndex].comments.add(comment);
    notifyListeners();
  }
}

}
