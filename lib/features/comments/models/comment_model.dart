class CommentModel {
  final int id;
  final String body;
  final int postId;
  final int userId;
  final String? userUsername;

  CommentModel({
    required this.id,
    required this.body,
    required this.postId,
    required this.userId,
    this.userUsername,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      postId: json['postId'] ?? 0,
      userId: json['userId'] ?? 0,
      userUsername: json['user']['username'] ?? json['userUsername'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'postId': postId,
      'userId': userId,
    };
  }
}

