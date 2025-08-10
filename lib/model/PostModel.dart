class Post {
  final String userName;
  final String postTime;
  final String postText;
  final String? userimage;
  final List<String>? imageUrls;
  final List<Comment>? comments;

  Post({
    required this.userName,
    required this.postTime,
    required this.postText,
    this.userimage,
    this.imageUrls,
    this.comments
  });
}

class Comment {
  final String userName;
  final String text;

  Comment({required this.userName, required this.text});
}


List<Post> mockPosts = [
  Post(
    userName: "Sumit Vondo",
    postTime: "1 hour ago",
    postText:
    "In today’s fast-paced world, mental health is more important than ever—yet finding accessible, meaningful support remains a challenge...",
    imageUrls:[
    "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQaYYxhaz3JMcWBsF6NQ3072oHDnWom4LwAdeK2SKT2qx3USSMg"],
  ),
  Post(
    userName: "Jane Doe",
    postTime: "2 hours ago",
    postText: "Nature walks always help me refresh and reset. 🌿",
    imageUrls: null,
  ),
  Post(
    userName: "Alex Johnson",
    postTime: "3 hours ago",
    postText:
    "Just finished a 10k run! Feeling energized and motivated to keep pushing my limits.",
    imageUrls:[
    "https://images.unsplash.com/photo-1549924231-f129b911e442?auto=format&fit=crop&w=800&q=60"],
  ),
  Post(
    userName: "Maria Lopez",
    postTime: "5 hours ago",
    postText:
    "Cooking is such a great way to unwind after a busy day. Today I tried a new recipe for vegan lasagna.",
    imageUrls:[
    "https://images.unsplash.com/photo-1512058564366-c9e9bfe0d22a?auto=format&fit=crop&w=800&q=60"],
  ),
  Post(
    userName: "David Kim",
    postTime: "6 hours ago",
    postText: "No better feeling than curling up with a good book and a cup of tea.",
    imageUrls: null,
  ),
  Post(
    userName: "Sophia Lee",
    postTime: "8 hours ago",
    postText:
    "Just booked my next travel adventure to Japan! Can’t wait to explore and share photos.",
    imageUrls:[
    "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60"],
  ),
];
