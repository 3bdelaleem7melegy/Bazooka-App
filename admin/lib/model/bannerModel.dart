// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class BannerModel {
  String text;
  List<Color> cardBackground;
  String image;

  BannerModel(this.text, this.cardBackground, this.image);
}

class BannerModelSpecial {
  String text;
  List<Color> cardBackground;
  String image;

  BannerModelSpecial(this.text, this.cardBackground, this.image);
}

List<BannerModel> bannerSpecialMeals = [
  BannerModel(
    "MEALS",
    [
      const Color(0xffa1d4ed),
      const Color(0xffc0eaff),
    ],
    "assets/Bazooka Golden Variety Large.jpg",
  ),
  BannerModel(
      "Family Meals",
      [
        const Color(0xffb6d4fa),
        const Color(0xffcfe3fc),
      ],
      "assets/s-1715959982406165.jpg"),

];
List<BannerModel> bannerSpecialSandwiches = [
  
  BannerModel(
      "Bazooka Sandwiches",
      [
        const Color(0xffb6d4fa),
        const Color(0xffcfe3fc),
      ],
      "assets/s-1723376066892329.jpg"),
      BannerModel(
    "Beaf Sandwiches",
    [
      const Color(0xffa1d4ed),
      const Color(0xffc0eaff),
    ],
    "assets/s-1723558746722358.jpg",
  ),

];


List<BannerModel> bannerSpecialExtra = [

  BannerModel(
    "Extra",
    [
      const Color(0xffa1d4ed),
      const Color(0xffc0eaff),
    ],
    "assets/images.jpg",
  ),
    BannerModel(
    "Appatizer",
    [
      const Color(0xffa1d4ed),
      const Color(0xffc0eaff),
    ],
    "assets/images (1).jpg",
  ),
];
