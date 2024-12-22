class User {
  final String id;
  final String name;
  final String username;

  User({
    required this.id,
    required this.name,
  }) : username = '${name.split(' ')[0].toLowerCase()}${id.substring(0, 3)}';

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
    );
  }
}
