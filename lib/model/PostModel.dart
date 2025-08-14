// models/post_model.dart
class Comment {
  final String userName;
  final String text;

  Comment({required this.userName, required this.text});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userName: json['userName'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'text': text,
    };
  }
}

class PostModel {
  final String id ;
  final String username;
  final String timeAgo;
  final String text;
  final List<String> imageUrls;
  final String? tag;
  final int likeCount;
  final bool isLiked;
  final List<Comment> comments;

  PostModel({
    this.id = '1',
    required this.username,
    required this.timeAgo,
    required this.text,
    required this.imageUrls,
    required this.tag,
    required this.likeCount,
    required this.isLiked,
    this.comments = const [],
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '1',
      username: json['username'],
      timeAgo: json['timeAgo'],
      text: json['text'],
      imageUrls: List<String>.from(json['imageUrls']),
      tag: json['tag'],
      likeCount: json['likeCount'],
      isLiked: json['isLiked'],
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'timeAgo': timeAgo,
      'text': text,
      'imageUrls': imageUrls,
      'tag': tag,
      'likeCount': likeCount,
      'isLiked': isLiked,
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }
}

