// ignore_for_file: unnecessary_null_comparison, file_names, unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, non_constant_identifier_names, use_build_context_synchronously, avoid_unnecessary_containers, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users/AuthFirebase/login_screen.dart';
import 'package:users/homepage/mainPage.dart';
import 'package:users/model/patient_model.dart';
import 'package:users/model/appointment_model.dart';
import 'package:users/model/Food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:users/myAppointents/myAppointmentsPagePending.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingScreenSANDWICHES extends StatefulWidget {
  Food food;

  BookingScreenSANDWICHES({super.key, required this.food});

  @override
  _BookingScreenSANDWICHESState createState() =>
      _BookingScreenSANDWICHESState();
}

class _BookingScreenSANDWICHESState extends State<BookingScreenSANDWICHES> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _SpecailController = TextEditingController();
  final TextEditingController _FoodController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _PhoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _LocationController = TextEditingController();
  final TextEditingController _LocationUserController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();
  FocusNode f7 = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String timeText = 'Select Time';
  late String dateUTC;
  late String date_Time;
  String selectedPriceType =
      'Choose Item'; // القيمة الحالية المحددة بين 'Single' و 'Double'
  String currentPrice = ''; // لتخزين السعر الحالي المعروض بناءً على الاختيار
  int selectedMealCount = 1; // العدد الافتراضي

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date!;
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime, // Use current time as initial time
    );

    // Ensure that a time was selected
    if (selectedTime != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);

      // Format the time into a 12-hour format (e.g., 1:50 PM)
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);

      setState(() {
        // Save the formatted time as a string
        timeText = formattedTime;
        _timeController.text = timeText;
      });

      // Optionally, you can extract the time as a string in the format you need (HH:mm) if needed
      date_Time = selectedTime.format(context); // This formats as '1:50 PM'
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 23),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        "Done!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 238, 220, 88),
        ),
      ),
      content: const Text(
        "Book is registered.",
        style: TextStyle(
          color: Color.fromARGB(255, 238, 220, 88),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchPriceFromFirebase(); // استرجاع السعر عند تحميل الصفحة

    _getUser();
    selectTime(context);
    String priceString =
        widget.food.Price.join(", "); // تحويل List إلى String مفصول بفواصل

    _FoodController.text = widget.food.name;
    _nameController.text = user.displayName!; //patient!.name;
    _idController.text = user.uid; //patient!.id;
    _SpecailController.text = widget.food.Special;
    _PhoneController.text =_PhoneController.text;
    _descriptionController.text = widget.food.description;
    _PriceController.text = priceString;
    _LocationController.text = _LocationController.text;
    _LocationUserController.text = _LocationUserController.text;
  }
  

  Future<void> fetchPriceFromFirebase() async {
    // هنا نسترجع البيانات من Firebase بناءً على `selectedPriceType`
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Foods')
        .doc(widget.food.id)
        .get();
    final data = snapshot.data() as Map<String, dynamic>;

    // تحقق من قيمة `selectedPriceType` لعرض السعر الصحيح
    if (selectedPriceType == 'Single') {
      setState(() {
        currentPrice = data['Price'][0]; // اختر السعر الأول (Single)
      });
    } else if (selectedPriceType == 'Double') {
      setState(() {
        if (data['Price'].length > 1) {
          // إذا كان السعر الثاني موجودًا
          currentPrice = data['Price'][1];
        } else {
          // إذا كان السعر الثاني غير موجود
          currentPrice = ''; // رسالة توضح أن السعر غير متوفر
        }
      });
    } else if (selectedPriceType == 'Triple') {
      setState(() {
        if (data['Price'].length > 2) {
          // إذا كان السعر الثاني موجودًا
          currentPrice = data['Price'][2];
        } else {
          // إذا كان السعر الثاني غير موجود
          currentPrice = ''; // رسالة توضح أن السعر غير متوفر
        }
      });
    } else if (selectedPriceType == 'Choose Item') {
      setState(() {
        currentPrice = ''; // اختر السعر الثاني (Double)
      });
    }

    setState(() {
      currentPrice = (int.parse(currentPrice) * selectedMealCount).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Booking',
          style: TextStyle(
            color: Color.fromARGB(255, 238, 220, 88),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 238, 220, 88),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          // onNotification: (OverscrollIndicatorNotification overscroll) {
          //   overscroll.disallowIndicator();
          //   return;
          // },
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Image(
                  image: AssetImage(
                    widget.food.imageUrl != null || widget.food.imageUrl.isEmpty
                        ? widget.food.imageUrl
                        : 'assets/appointment.jpg',
                  ),
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(widget.doctor.monday!.first),
              Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 16),
                        child: const Text(
                          'Enter Patient Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _nameController,
                        focusNode: f1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Patient Name';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Patient Name*',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          f1.unfocus();
                          FocusScope.of(context).requestFocus(f2);
                        },
                        textInputAction: TextInputAction.next,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        focusNode: f2,
                        controller: _idController,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'id*',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Phone number';
                          } else if (value.length < 10) {
                            return 'Please Enter correct Phone number';
                          }
                          return null;
                        },
                        onFieldSubmitted: (String value) {
                          f2.unfocus();
                          FocusScope.of(context).requestFocus(f3);
                        },
                        textInputAction: TextInputAction.next,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        focusNode: f3,
                        controller: _SpecailController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Special',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          f3.unfocus();
                          FocusScope.of(context).requestFocus(f4);
                        },
                        textInputAction: TextInputAction.next,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _FoodController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please enter Food name';
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Food Name*',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        enabled: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: 3,
                        controller: _descriptionController,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter Food Description';
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Food Description*',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButton<String>(
                        iconSize: 50,
                        iconEnabledColor: Colors.yellow, // تغيير لون الأيقونة

                        value: selectedPriceType,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPriceType = newValue!;
                            fetchPriceFromFirebase(); // عند تغيير الاختيار، استرجاع السعر من Firebase
                          });
                        },
                        items: <String>[
                          'Choose Item',
                          'Single',
                          'Double',
                          'Triple'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .yellow, // يمكنك تعديل اللون حسب الحاجة
                              ),
                            ),
                          );
                        }).toList(),

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        dropdownColor: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //                     Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         if (selectedMealCount > 1) {
                      //           setState(() {
                      //             selectedMealCount--;
                      //             fetchPriceFromFirebase(); // تحديث السعر عند تقليل العدد
                      //           });
                      //         }
                      //       },
                      //       icon: Icon(Icons.remove_circle, color: Colors.red),
                      //     ),
                      //     Text(
                      //       '$selectedMealCount',
                      //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      //     ),
                      //     IconButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           selectedMealCount++;
                      //           fetchPriceFromFirebase(); // تحديث السعر عند زيادة العدد
                      //         });
                      //       },
                      //       icon: Icon(Icons.add_circle, color: Colors.green),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (selectedMealCount > 1) {
                                setState(() {
                                  selectedMealCount--;
                                  fetchPriceFromFirebase(); // تقليل العدد وتحديث السعر
                                });
                              }
                            },
                            icon: Icon(Icons.arrow_circle_down,
                                color: Colors.red), // سهم لأسفل
                          ),
                          Text(
                            '$selectedMealCount',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedMealCount++;
                                fetchPriceFromFirebase(); // زيادة العدد وتحديث السعر
                              });
                            },
                            icon: Icon(Icons.arrow_circle_up,
                                color: Colors.green), // سهم لأعلى
                          ),
                        ],
                      ),

                      TextFormField(
                        controller: _PriceController
                          ..text =
                              currentPrice, // تحديث الحقل تلقائيًا عندما يتغير السعر
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Price',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'L.E', // النص
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                  width: 5), // مسافة بين النص والقيمة
                            ],
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Price';
                          }
                          return null;
                        },
                        enabled:
                            false, // إذا كنت لا تريد أن يتمكن المستخدم من تعديل السعر يدوياً
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        focusNode: f4,
                        controller: _PhoneController,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Phone Number*',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Phone number';
                          } else if (value.length < 10) {
                            return 'Please Enter correct Phone number';
                          }
                          return null;
                        },
                        onFieldSubmitted: (String value) {
                          f4.unfocus();
                          FocusScope.of(context).requestFocus(f5);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DropdownButtonFormField<String>(
                        focusNode: f5,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Select Location',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter the Location';
                          return null;
                        },
                        items: [
                          'El Hijaz',
                          'Faisal',
                          'Fifth Settlement',
                          'Nasr City',
                          'El Shiekh Zayed',
                          'El Haram',
                          'Shoubra'
                              'El Mokatam'
                        ]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                      color: Colors
                                          .black, // Change the color to your desired color
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          log(value!);

                          setState(() {
                            _LocationController.text = value;
                          });
                          f5.unfocus();
                          FocusScope.of(context).requestFocus(f6);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _LocationUserController,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Your Location',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Location';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextFormField(
                              focusNode: f6,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[350],
                                hintText: 'Select Date*',
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              controller: _dateController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter the Date';
                                }
                                return null;
                              },
                              onFieldSubmitted: (String value) {
                                f6.unfocus();
                                FocusScope.of(context).requestFocus(f7);
                              },
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ClipOval(
                                child: Material(
                                  color: Colors.black, // button color
                                  child: InkWell(
                                    // inkwell color
                                    child: const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.date_range_outlined,
                                        color:
                                            Color.fromARGB(255, 238, 220, 88),
                                      ),
                                    ),
                                    onTap: () {
                                      selectDate(context);
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextFormField(
                              focusNode: f7,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[350],
                                hintText: 'Select Time*',
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              controller: _timeController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter the Time';
                                }
                                return null;
                              },
                              onFieldSubmitted: (String value) {
                                f7.unfocus();
                              },
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ClipOval(
                                child: Material(
                                  color: Colors.black, // button color
                                  child: InkWell(
                                    // inkwell color
                                    child: const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.timer_outlined,
                                        color:
                                            Color.fromARGB(255, 238, 220, 88),
                                      ),
                                    ),
                                    onTap: () {
                                      selectTime(context);
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.black,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print(_nameController.text);
                              print(_dateController.text);
                              print(widget.food);
                              showAlertDialog(context);
                              await _createAppointment();
                            }
                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    // try {
    //   // final patient = Patient(email: 'email', id: 'id', name: 'name', phoneNumber: 'phoneNumber', imageUrl: 'imageUrl', bio: 'bio');
    //   final patient = await getCachedPatient();
    //   final model = Appointment(
    //     id: DateTime.now().toString(),
    //     date: dateUTC,
    //     patient: patient!,
    //     food: widget.food,
    //     time: date_Time,
    //   );
    //   // await FirebaseFirestore.instance
    //   //     .collection("Foods")
    //   //     .doc(widget.food.id)
    //   //     .update(widget.food.toFireStore());
    //   log(model.toFireStore().toString());
    //   await FirebaseFirestore.instance
    //       .collection('Appointments')
    //       .doc(widget.food.Special)
    //       .collection('All')
    //       .doc(model.id)
    //       .set(model.toFireStore(), SetOptions(merge: true))
    //       .then((value) async {
    //     await FirebaseFirestore.instance
    //         .collection('Appointments')
    //         .doc(widget.food.Special)
    //         .collection('Pending')
    //         .doc(model.id)
    //         .set(model.toFireStore(), SetOptions(merge: true))
    //         .then((value) async {
    //       await FirebaseFirestore.instance
    //           .collection('Appointments')
    //           .doc(widget.food.Special)
    //           .collection('Pending')
    //           .doc(model.id)
    //           .set({
    //         'PhoneNumber': _PhoneController.text,
    //         'description': _descriptionController.text,
    //         'Price': _PriceController.text
    //       }, SetOptions(merge: true));
    //     }).then((value) async {
    //       await FirebaseFirestore.instance
    //           .collection('Appointments')
    //           .doc(widget.food.Special)
    //           .collection('All')
    //           .doc(model.id)
    //           .set({
    //         'PhoneNumber': _PhoneController.text,
    //         'description': _descriptionController.text,
    //         'Price': _PriceController.text
    //       }, SetOptions(merge: true));
    //     }).catchError((e) {
    //       log(e.toString());
    //     });
    //   }).catchError((e) {
    //     log(e.toString());
    //   });
    // } catch (e) {
    //   log(e.toString());
    // }
    FirebaseFirestore.instance.collection('AppointmentsAll').doc().set({
      'name': _nameController.text,
      'id': _idController.text,
      'PhoneNumber': _PhoneController.text,
      'FoodName': _FoodController.text,
      'description': _descriptionController.text,
      'date': dateUTC,
      'time': date_Time,
      'Price': _PriceController.text,
      'Special': _SpecailController.text,
      'Location': _LocationController.text,
      'LocationUser': _LocationUserController.text,
      'Number': selectedMealCount, // الحقل الذي تريد تحديثه

    }, SetOptions(merge: true));
    FirebaseFirestore.instance
        .collection('Appointments')
        .doc(user.email)
        .collection('Pending')
        .doc()
        .set({
      'name': _nameController.text,
      'id': _idController.text,
      'PhoneNumber': _PhoneController.text,
      'FoodName': _FoodController.text,
      'description': _descriptionController.text,
      'date': dateUTC,
      'time': date_Time,
      'Price': _PriceController.text,
      'Special': _SpecailController.text,
      'Location': _LocationController.text,
      'LocationUser': _LocationUserController.text,
      'Number': selectedMealCount, // الحقل الذي تريد تحديثه

    }, SetOptions(merge: true));
  }
}
