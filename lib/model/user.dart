class User {
  final String id;
  final String name;
  final String username;

  User({
    required this.id,
    required this.name,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] as String,
      username: json['username'] as String,
    );
  }
}
