import 'package:users/model/patient_model.dart';
import 'package:users/model/Food_model.dart';


class Appointment {
  final String? id;
  final String date;
  final Food food;
  final Users users;
  final String time;

  Appointment({
    this.id,
    required this.date,
    required this.time,
    required this.users,
    required this.food,
  });

  factory Appointment.formJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      date: json['date'],
      time: json['time'] ?? '',
      users: Users.formJson(json['users']),
      food: Food.formJson(json['food']),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "date": date,
      "time": time,
      "food": food.toFireStore(),
      "users": users.toFireStore(),
    };
  }
}
