import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? username;
  String? name;
  String? lastname;
  String? email;
  String? password;
  String? image;

  User({this.id, this.username, this.email, this.password, this.image, this.name, this.lastname});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "lastname": lastname,
        "email": email,
        "image": image,
      };
}
