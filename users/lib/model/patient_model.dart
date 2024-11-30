class Users {
  String id;
  String name;
  String email;
  String phoneNumber;
  String imageUrl;
  String bio;

  Users({
    required this.email,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.bio,
  });

  factory Users.formJson(Map<String, dynamic> json) {
    return Users(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
      "bio": bio,
    };
  }
}