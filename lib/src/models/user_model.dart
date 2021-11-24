import 'dart:convert';

class Users {
  final String name;
  final String email;
  final String? photoUrl;
  Users({required this.name, required this.email, this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));
}
