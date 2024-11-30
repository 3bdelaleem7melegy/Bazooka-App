// ignore_for_file: file_names, prefer_const_constructors

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users/food/booking_screenExtra.dart';
import 'package:users/food/booking_screenSANDWICHES.dart';
import 'package:users/model/Food_model.dart';
import 'package:users/food/DoctorsBottomSheetWidget.dart';
import 'package:users/food/LocationssBottomSheetWidget.dart';
import 'package:users/food/ViewsModel.dart';
import 'package:users/food/booking_screenMEALS.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SpecailList extends StatefulWidget {
  const SpecailList({super.key, required this.specailList});
  final String specailList;

  @override
  State<SpecailList> createState() => _CardiologistState();
}

class _CardiologistState extends State<SpecailList> {
  List<int>? filterIndex;
  String FoodName = '';
  String FoodLoaction = '';
  List<Food> Foods = [];
  List<Food> filterFoods = [];
  String? selectedFood; // الاختيار الحالي

  final TextEditingController _doctorName = TextEditingController();

  ViewModell viewModell = ViewModell();

  @override
  void initState() {
    super.initState();
    getData();
    viewModell.loadData();
  }

  Future<void> getData() async {
    final res = await FirebaseFirestore.instance
        .collection('Foods')
        .where('Special', isEqualTo: widget.specailList)
        .get();
    final data = res.docs.map((e) => Food.formJson(e.data())).toList();

    setState(() {
      Foods = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModell,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            // 'Dentist',
            widget.specailList,
            style: TextStyle(
              color: Color.fromARGB(255, 238, 220, 88),
            ),
          ),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // DropdownButton(
                    //   hint: Text(
                    //     'Select Food',
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    //   items: Foods.map((e) => DropdownMenuItem(
                    //         value: e.name,
                    //         child: Text(e.name),
                    //       )).toList(),
                    //   onChanged: (val) {
                    //     filterFoods =
                    //         Foods.where((e) => e.name == val).toList();
                    //     setState(() {});
                    //   },
                    // ),
                    DropdownButton<String>(
                      dropdownColor: Colors.black,
                      hint: Text(
                        'Select Food',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 238, 220, 88),
                        ),
                      ),
                      value: selectedFood,
                      items: Foods.map((e) => DropdownMenuItem<String>(
                            value: e.name,
                            child: Text(
                              e.name,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 238, 220, 88)),
                            ),
                          )).toList(),
                      onChanged: (val) {
                        selectedFood = val;
                        filterFoods =
                            Foods.where((e) => e.name == val).toList();
                        setState(() {});
                      },
                    ),

                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Color.fromARGB(255, 238, 220, 88),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedFood = null; // إزالة الاختيار
                          filterFoods.clear(); // مسح القائمة المفلترة
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    filterFoods.isEmpty ? Foods.length : filterFoods.length,
                itemBuilder: (context, index) => FoodItem(
                    food: filterFoods.isEmpty
                        ? Foods[index]
                        : filterFoods[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDoctorssModalBottomSheet(List<String> doctors) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) => DoctorsBottomSheetWidget(viewModell: viewModell));
  }

  showLocationssModalBottomSheet(List<String> locations) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) =>
            LocationssBottomSheetWidget(viewModell: viewModell));
  }
}

class FoodItem extends StatelessWidget {
  const FoodItem({super.key, required this.food});
  final Food food;
  @override
  Widget build(BuildContext context) {
    // return InkWell(
    //   onTap: () {
    //     // Navigator.push(
    //     //     context,
    //     //     MaterialPageRoute(
    //     //         builder: (context) => BookingScreen(food: food)));
    //     if (food.Special == 'MEALS' || food.Special == 'Family Meals') {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => BookingScreenMEALS(food: food),
    //         ),
    //       );
    //     } else if (food.Special == 'Bazooka Sandwiches' ||
    //         food.Special == 'Beaf Sandwiches') {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => BookingScreenSANDWICHES(food: food),
    //         ),
    //       );
    //     } else {
    //       // يمكنك وضع شرط آخر أو رسالة خطأ هنا
    //       print('Category not recognized');
    //     }
    //   },
    //   child: Container(
    //     padding: EdgeInsets.all(10),
    //     margin: EdgeInsets.all(10),
    //     decoration: BoxDecoration(
    //       color: Colors.blue[700],
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     child: Row(children: [
    //       Container(
    //         child: CircleAvatar(
    //           backgroundImage: AssetImage(food.imageUrl),
    //           radius: 50,
    //         ),
    //       ),
    //       SizedBox(
    //         width: 30,
    //       ),
    //       Column(
    //         children: [
    //           Container(
    //             child: Text(
    //               food.name,
    //               style: TextStyle(fontSize: 20, color: Colors.white),
    //             ),
    //           ),
    //           Container(
    //             child: Text(
    //               food.phoneNumber,
    //               style: TextStyle(fontSize: 20, color: Colors.white),
    //             ),
    //           ),
    //           Container(
    //             child: Text(
    //               food.Price.isNotEmpty
    //                   ? (food.Price.length == 1
    //                       ? 'Normal: ${food.Price[0]} L.E' // إذا كان هناك عنصر واحد فقط
    //                       : food.Price.length == 2
    //                           ? 'Single: ${food.Price[0]} L.E\nDouble: ${food.Price[1]} L.E' // إذا كان هناك عنصرين
    //                           : 'Single: ${food.Price[0]} L.E\nDouble: ${food.Price[1]} L.E\nTriple: ${food.Price[2]} L.E') // إذا كان هناك ثلاثة عناصر
    //                   : '', // إذا كانت القائمة فارغة
    //               style: TextStyle(fontSize: 20, color: Colors.white),
    //             ),
    //           ),

    //           //   Container(
    //           //   child: Text(
    //           //     food.Price.isNotEmpty ? food.Price[1] : "No Price",
    //           //     style: TextStyle(fontSize: 20, color: Colors.white),
    //           //   ),
    //           // ),
    //         ],
    //       ),
    //     ]),
    //     //
    //   ),
    // );

    return InkWell(
      onTap: () {
        if (food.Special == 'MEALS' || food.Special == 'Family Meals') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingScreenMEALS(food: food),
            ),
          );
        } else if (food.Special == 'Bazooka Sandwiches' ||
            food.Special == 'Beaf Sandwiches') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingScreenSANDWICHES(food: food),
            ),
          );
        } else if (food.Special == 'Extra' ||
            food.Special == 'Appatizer') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingScreenExtra(food: food),
            ),
          );
        } else {
          print('Category not recognized');
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(food.imageUrl),
              radius: 50,
            ),
            SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // محاذاة النصوص إلى اليسار
                children: [
                  AutoSizeText(
                    food.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 238, 220, 88),
                    ),
                    maxLines: 1, // عدد السطور المسموح به
                  ),
                  AutoSizeText(
                    food.phoneNumber,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    maxLines: 1,
                  ),
                  // AutoSizeText(
                  //   food.Price.isNotEmpty
                  //       ? (food.Price.length == 1
                  //           ? 'Normal: ${food.Price[0]} L.E'
                  //           : food.Price.length == 2
                  //               ? 'Single: ${food.Price[0]} L.E\nDouble: ${food.Price[1]} L.E'
                  //               : 'Single: ${food.Price[0]} L.E\nDouble: ${food.Price[1]} L.E\nTriple: ${food.Price[2]} L.E')
                  //       : '',
                  //   style: TextStyle(fontSize: 18, color: Colors.white),
                  //   maxLines: 3,
                  // ),
                  RichText(
                    text: TextSpan(
                      children: food.Price.isNotEmpty
                          ? (food.Price.length == 1
                              ? [
                                  const TextSpan(
                                    text: 'Normal: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 238, 220, 88),
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${food.Price[0]} L.E',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ]
                              : food.Price.length == 2
                                  ? [
                                      TextSpan(
                                        text: 'Single: ',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 238, 220, 88),
                                          // اللون الأصفر لكلمة Single
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${food.Price[0]} L.E\n',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      const TextSpan(
                                        text: 'Double: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 238, 220, 88),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${food.Price[1]} L.E',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ]
                                  : [
                                      TextSpan(
                                        text: 'Single: ',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 238, 220,
                                              88), // اللون الأصفر لكلمة Single
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${food.Price[0]} L.E\n',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      const TextSpan(
                                        text: 'Double: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 238, 220, 88),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${food.Price[1]} L.E\n',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      const TextSpan(
                                        text: 'Triple: ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 238, 220, 88)),
                                      ),
                                      TextSpan(
                                        text: '${food.Price[2]} L.E',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ])
                          : [],
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
