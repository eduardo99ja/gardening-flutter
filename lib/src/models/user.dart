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
  bool? isAdmin;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.image,
      this.name,
      this.lastname,
      this.isAdmin = false});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        isAdmin: json["isAdmin"],
      );

  User.fromElement(elemento) {
    id = elemento["id"];
    username = elemento["username"];
    name = elemento["name"];
    lastname = elemento["lastname"];
    email = elemento["email"];
    //password = elemento["password"];
    image = elemento["image"];
    isAdmin = elemento["isAdmin"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "lastname": lastname,
        "email": email,
        "image": image,
        "isAdmin": isAdmin,
      };
}
