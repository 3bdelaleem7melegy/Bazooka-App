class Food {
  String id;
  String name;
  String phoneNumber;
  String imageUrl;
  String location;
  String Special;
  List<String> Price; // تغيير إلى List<String>
  String description;

  Food(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.imageUrl,
      required this.location,
      required this.Price,
      // required this.Certificates,
      required this.Special,
      required this.description});

  factory Food.formJson(Map<String, dynamic> json) {
    return Food(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        imageUrl: json['imageUrl'] ?? '',
        location: json['location'],
        Price:
            List<String>.from(json['Price'] ?? []), // تحويلها إلى List<String>
        // Certificates: json['Certificates'],
        Special: json['Special'],
        description: json['description']);
  }

  Map<String, dynamic> toFireStore() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["phoneNumber"] = phoneNumber;
    data["imageUrl"] = imageUrl;
    data["location"] = location;
    data["Price"] = Price;
    data["Special"] = Special;
    data["description"] = description;

    return data;
  }

  static FromFirestore(Map<String, dynamic> data, String id) {}
}
