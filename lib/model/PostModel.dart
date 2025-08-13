// models/post_model.dart
class PostModel {
  final String username;
  final String timeAgo;
  final String text;
  final List<String> imageUrls;
  final String? tag;
  final int likeCount;
  final bool isLiked;

  PostModel({
    required this.username,
    required this.timeAgo,
    required this.text,
    required this.imageUrls,
    required this.tag,
    required this.likeCount,
    required this.isLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      username: json['username'],
      timeAgo: json['timeAgo'],
      text: json['text'],
      imageUrls: List<String>.from(json['imageUrls']),
      tag: json['tag'],
      likeCount: json['likeCount'],
      isLiked: json['isLiked'],
    );
  }
}
