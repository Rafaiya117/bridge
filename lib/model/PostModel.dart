class Post {
  final String userName;
  final String postTime;
  final String postText;
  final String? imageUrl;
  final List<Comment>? comments;

  Post({
    required this.userName,
    required this.postTime,
    required this.postText,
    this.imageUrl,
    this.comments
  });
}

class Comment {
  final String userName;
  final String text;

  Comment({required this.userName, required this.text});
}