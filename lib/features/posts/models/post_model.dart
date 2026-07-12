class PostModel {
  final int id;
  final String title;
  final String body;
  final int userId;
  final String? userUsername;
  final List<String> tags;
  final int reactions;
  final int comments;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.userUsername,
    required this.tags,
    required this.reactions,
    required this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    String? username;
    if (json['user'] != null && json['user'] is Map<String, dynamic>) {
      username = json['user']['username'] ?? json['user']['firstName'];
    }
    
    int reactionCount = 0;
    if (json['reactions'] is int) {
      reactionCount = json['reactions'];
    } else if (json['reactions'] is Map) {
      reactionCount = (json['reactions'] as Map)['total'] ?? 0;
      if ((json['reactions'] as Map).containsKey('likes')) {
        reactionCount = (json['reactions'] as Map)['likes'] ?? 0;
      }
    }
    
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userId: json['userId'] ?? 0,
      userUsername: username ?? json['userUsername'],
      tags: List<String>.from(json['tags'] ?? []),
      reactions: reactionCount,
      comments: json['comments'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'userId': userId,
    };
  }
}
