
import 'package:staff/model/Food_model.dart';
import 'package:staff/model/Staff_model.dart';


class Appointment {
  final String? id;
  final String date;
  final Food food;
  final Staff staff;
  final String time;

  Appointment({
    this.id,
    required this.date,
    required this.time,
    required this.staff,
    required this.food,
  });

  factory Appointment.formJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      date: json['date'],
      time: json['time'] ?? '',
      staff: Staff.formJson(json['staff']),
      food: Food.formJson(json['food']),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "date": date,
      "time": time,
      "food": food.toFireStore(),
      "staff": staff.toFireStore(),
    };
  }
}
