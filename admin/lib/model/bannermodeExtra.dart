// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:admin/Food/Special_List.dart';
import 'package:admin/model/bannerModel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



class modelExtra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: bannerSpecialMeals.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            //alignment:  Alignment.centerLeft,
            //width: MediaQuery.of(context).size.width,
            height: 140,
            margin: EdgeInsets.only(left: 0, right: 0, bottom: 20),
            padding: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                stops: [0.3, 0.7],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: bannerSpecialExtra[index].cardBackground,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                if (index >= bannerSpecialExtra.length - 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SpecailList(specailList: bannerSpecialExtra[index].text),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SpecailList(specailList: bannerSpecialExtra[index].text),
                    ),
                  );
                }

              
              },
              child: Stack(
  children: [
    // الصورة
    Image.asset(
      bannerSpecialExtra[index].image,
      fit: BoxFit.cover, // الصورة تغطي بالكامل
      width: double.infinity, // ملء العرض بالكامل
      height: 200, // يمكن ضبط الارتفاع حسب الحاجة
    ),
    // النص فوق الصورة
    Positioned(
      top: 10, // المسافة من الأعلى
      right: 10, // المسافة من اليمين
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5), // خلفية نصف شفافة
          borderRadius: BorderRadius.circular(5), // زوايا مستديرة
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // فقط بحجم النص
          children: [
            Text(
              bannerSpecialExtra[index].text,
              style: const TextStyle(
                color: const Color.fromARGB(255, 238, 220, 88), // النص باللون الأبيض
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: const Color.fromARGB(255, 238, 220, 88),// الأيقونة باللون الأبيض
              size: 20,
            ),
          ],
        ),
      ),
    ),
  ],
),

            ),
          );
        },
        options: CarouselOptions(
          autoPlay:true,
          autoPlayInterval: Duration(seconds: 5),
          // autoPlayAnimationDuration: Duration(milliseconds: 800),
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          scrollPhysics: ClampingScrollPhysics(),
        ),
        
      ),
      
    );
  }
}
