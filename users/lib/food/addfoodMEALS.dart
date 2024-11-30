// // ignore_for_file: deprecated_member_use

// import 'dart:developer';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:muslimapp/homepage/mainPage.dart';
// import 'package:muslimapp/model/Food_model.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// class MEALS extends StatefulWidget {
//   @override
//   _MEALSState createState() => _MEALSState();
// }

// class _MEALSState extends State<MEALS> {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _displayName = TextEditingController();
//   final TextEditingController _description = TextEditingController();
//   final TextEditingController _phoneNumber = TextEditingController();
//   final TextEditingController _Location = TextEditingController();
//   final TextEditingController _Price = TextEditingController();
//   final TextEditingController _image = TextEditingController();
//   File? _pickedImage;

//   FocusNode f1 = FocusNode();
//   FocusNode f2 = FocusNode();
//   FocusNode f3 = FocusNode();
//   FocusNode f4 = FocusNode();
//   FocusNode f5 = FocusNode();
//   FocusNode f6 = FocusNode();
//   FocusNode f7 = FocusNode();
//   // FocusNode f8 = FocusNode();
//   // FocusNode f9 = FocusNode();

//   bool _isSuccess = true;
//   String special = '';

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: NotificationListener<OverscrollIndicatorNotification>(
//             // onNotification: (OverscrollIndicatorNotification overscroll) {
//             //   overscroll.disallowGlow();
//             //   return;
//             // },
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
//                     child: _signUp(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _signUp() {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 16, left: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               padding: EdgeInsets.only(bottom: 50),
//               child: Text(
//                 'Add a Meals',
//                 style: GoogleFonts.lato(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             TextFormField(
//               focusNode: f1,
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               controller: _displayName,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(90.0)),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[350],
//                 hintText: 'Name',
//                 hintStyle: GoogleFonts.lato(
//                   color: Colors.black26,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               onFieldSubmitted: (value) {
//                 f1.unfocus();
//                 FocusScope.of(context).requestFocus(f1);
//               },
//               textInputAction: TextInputAction.next,
//               validator: (value) {
//                 if (value!.isEmpty) return 'Please enter the Name';
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
//               TextFormField(
//               focusNode: f2,
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               controller:_description ,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(90.0)),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[350],
//                 hintText: 'Description',
//                 hintStyle: GoogleFonts.lato(
//                   color: Colors.black26,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
                  
//                 ),
//               ),
//               onFieldSubmitted: (value) {
//                 f2.unfocus();
//                 FocusScope.of(context).requestFocus(f2);
//               },
//               textInputAction: TextInputAction.next,
//               validator: (value) {
//                 if (value!.isEmpty) return 'Please enter the Description';
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
//             DropdownButtonFormField<String>(
//               focusNode: f3,
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(90.0)),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[350],
//                 hintText: 'Specailization',
//                 hintStyle: GoogleFonts.lato(
//                   color: Colors.black26,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) return 'Please enter the Specailization';
//                 return null;
//               },
//               items: [
//                 'Sandwiches',
//                 'MEALS',
//                 'ophthalmologist',
//                 'Paediatrician',
//                 'orthopedics',
//               ]
//                   .map((e) => DropdownMenuItem(
//                         value: e,
//                         child: Text(
//                           e,
//                           style: const TextStyle(
//                             color: Colors
//                                 .black, // Change the color to your desired color
//                             fontSize: 18,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 log(value!);

//                 setState(() {
//                   special = value;
//                 });
//               },
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
//             TextFormField(
//               focusNode: f4,
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               controller: _phoneNumber,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(90.0)),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[350],
//                 hintText: 'phoneNumber',
//                 hintStyle: GoogleFonts.lato(
//                   color: Colors.black26,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               onFieldSubmitted: (value) {
//                 f4.unfocus();
//                 // FocusScope.of(context).requestFocus(f6);
//               },
//               textInputAction: TextInputAction.next,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter the phone';
//                 } else if (value.length < 4) {
//                   return 'Password must be at least 12 characters long';
//                 } else {
//                   return null;
//                 }
//               },
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
//             TextFormField(
//               focusNode: f5,
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               controller: _Location,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(90.0)),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[350],
//                 hintText: 'Location',
//                 hintStyle: GoogleFonts.lato(
//                   color: Colors.black26,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               onFieldSubmitted: (value) {
//                 f5.unfocus();
//                 FocusScope.of(context).requestFocus(f5);
//               },
//               textInputAction: TextInputAction.next,
//               validator: (value) {
//                 if (value!.isEmpty) return 'Please enter the Location';
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
            
//         TextFormField(
//   controller: _Price,
//   focusNode: f6,
//     style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//     decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(90.0)),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[350],
//                 hintText: 'Please Enter Price',
//                 hintStyle: GoogleFonts.lato(
//                   color: Colors.black26,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter the prices';
//     }
//     // تحقق من أن المدخل يحتوي على أرقام فقط
//     if (!RegExp(r'^\d+$').hasMatch(value)) {
//       return 'Please enter a valid price';
//     }
//     return null;
//   },
// ),



//             SizedBox(
//               height: 25.0,
//             ),
//             TextFormField(
//               focusNode: f7,
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               controller: _image,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(90.0)),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[350],
//                 hintText: 'Image',
//                 hintStyle: GoogleFonts.lato(
//                   color: Colors.black26,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               onFieldSubmitted: (value) {
//                 f7.unfocus();
//                 FocusScope.of(context).requestFocus(f7);
//               },
//               textInputAction: TextInputAction.next,
//               validator: (value) {
//                 if (value!.isEmpty) return 'Please enter the Name';
//                 return null;
//               },
//             ),
//           //   GestureDetector(
//           // onTap: _pickImage,
//           // child: Container(
//           //   width: 100,
//           //   height: 100,
//           //   color: Colors.grey[300],
//           //   child: _pickedImage == null
//           //       ? Icon(Icons.add_a_photo, size: 50)  // رمز إضافة صورة إذا لم يتم اختيار صورة بعد
//           //       : Image.file(
//           //           _pickedImage!,
//           //           fit: BoxFit.cover,
//           //         ),
//           // ),),
//             Container(
//               padding: const EdgeInsets.only(top: 25.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   child: Text(
//                     "Done",
//                     style: GoogleFonts.lato(
//                       color: Colors.white,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       _addfood();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black,
//                     elevation: 2,
//                     backgroundColor: Colors.indigo[900],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//  Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _pickedImage = File(image.path);
//       });
//     } else {
//       // في حال لم يختار المستخدم صورة
//       print('No image selected.');
//     }
//   }
//   Future<String> _uploadImage(File image) async {
//     try {
//       // تحميل الصورة إلى Firebase Storage
//       final storageRef = FirebaseStorage.instance.ref().child('food_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//       await storageRef.putFile(image);

//       // الحصول على رابط الصورة بعد الرفع
//       String imageUrl = await storageRef.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       print("Error uploading image: $e");
//       return '';
//     }
//   }
// //  void _addfood() async {
// //     if (_pickedImage != null) {
// //       // رفع الصورة إلى Firebase Storage
// //       String imageUrl = await _uploadImage(_pickedImage!);

// //       // إنشاء نموذج الطعام
// //       final model = Food(
// //         id: DateTime.now().toString(),
// //         name: _displayName.text,
// //         description: _description.text,
// //         phoneNumber: _phoneNumber.text,
// //         imageUrl: _image.text,
// //         location: _Location.text,
// //         Special: special,
// //         Price: _Price.text,
        
// //       );

// //       // تخزين البيانات في Firestore
// //       FirebaseFirestore.instance
// //           .collection('Foods')
// //           .doc(model.id)
// //           .set(model.toFireStore(), SetOptions(merge: true));

// //       Navigator.pop(context);
// //     } else {
// //       // في حال لم يتم اختيار صورة
// //       print("No image selected");
// //     }
// //   }
//   void _addfood() async {
//     String priceText = _Price.text;
//     List<String> priceList = _parsePrice(priceText);
//     final model = Food(
//       id: DateTime.now().toString(),
//       name: _displayName.text,
//       description: _description.text,
//       phoneNumber: _phoneNumber.text,
//       imageUrl: _image.text,
//       location: _Location.text,
//       Special: special,
//       Price: priceList,
//     );
//     print("object");
//     FirebaseFirestore.instance
//         .collection('Foods')
//         .doc(model.id)
//         .set(model.toFireStore(), SetOptions(merge: true));

//     // Navigator.of(context).pushNamedAndRemoveUntil(
//     //     '/AdminScreen', (Route<dynamic> route) => false);
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => MainPage()),
// );  }

// List<String> _parsePrice(String priceText) {
//   RegExp regExp = RegExp(r'^\d+$'); // فقط يبحث عن أرقام
//   Match? match = regExp.firstMatch(priceText);

//   if (match != null) {
//     return [match.group(0)!]; // إرجاع الرقم في قائمة واحدة
//   }
  
//   return []; // إذا لم تكن هناك قيمة صحيحة
// }

// }

// void _pushPage(BuildContext context, Widget page) {
//   Navigator.of(context).push(
//     MaterialPageRoute<void>(builder: (_) => page),
//   );
// }
