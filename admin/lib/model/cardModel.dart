// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
class CardModel {
  String doctor;
  int cardBackground;
  var cardIcon;

  CardModel(this.doctor, this.cardBackground, this.cardIcon);
}

List<CardModel> cards = [
  CardModel("MEALS", 0xFFec407a, Icons.heart_broken),
  CardModel("Family Meals", 0xFFfbc02d, Icons.remove_red_eye),
  CardModel("Bazooka Sandwiches", 0xFF5c6bc0, Icons.telegram),
  CardModel("Orthopaedic", 0xFF1565C0, Icons.wheelchair_pickup_sharp),
  CardModel("Beaf Sandwiches", 0xFF2E7D32, Icons.baby_changing_station),
];