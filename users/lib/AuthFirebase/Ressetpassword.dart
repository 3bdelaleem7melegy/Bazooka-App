// // // ignore: file_names
// // // ignore: file_names
// // // ignore: file_names
// // // ignore_for_file: use_key_in_widget_constructors, camel_case_types, sized_box_for_whitespace, prefer_const_constructors, unused_local_variable, non_constant_identifier_names, avoid_print, use_build_context_synchronously, unused_import, prefer_typing_uninitialized_variables, file_names, duplicate_ignore

// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class Signup extends StatefulWidget {
// //   const Signup({super.key});

// //   @override
// //   State<Signup> createState() => _SignupState();
// // }

// // class _SignupState extends State<Signup> {
// //   final auth = FirebaseAuth.instance;
// //   var showpass = true;
// //   late String email, password;
// //   late String name;
// //   var phone;
// //   bool showSpinner = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.blueGrey,
// //       appBar: AppBar(
// //         backgroundColor: Colors.blueGrey,
// //         title: const Text(
// //           "Sign up",
// //           style: TextStyle(color: Colors.white, fontSize: 30),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: ModalProgressHUD(
// //         inAsyncCall: showSpinner,
// //         child: Container(
// //           width: double.infinity,
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Container(
// //                   padding:
// //                       const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
// //                   decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(66)),
// //                   width: 266,
// //                   child: TextField(
// //                       onChanged: (value) {
// //                         name = value;
// //                       },
// //                       decoration: InputDecoration(
// //                         border: InputBorder.none,
// //                         hintText: "UserName : ",
// //                         hintStyle: TextStyle(fontSize: 19),
// //                         prefixIcon: Icon(Icons.person),
// //                       ))),
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               Container(
// //                   padding:
// //                       const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
// //                   decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(66)),
// //                   width: 266,
// //                   child: TextField(
// //                       onChanged: (value) {
// //                         email = value;
// //                       },
// //                       decoration: InputDecoration(
// //                         border: InputBorder.none,
// //                         hintText: "Enter your Email : ",
// //                         hintStyle: TextStyle(fontSize: 19),
// //                         prefixIcon: Icon(Icons.email),
// //                       ))),
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               Container(
// //                   padding:
// //                       const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
// //                   decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(66)),
// //                   width: 266,
// //                   child: TextField(
// //                       onChanged: (value) {
// //                         password = value;
// //                       },
// //                       obscureText: true,
// //                       decoration: InputDecoration(
// //                         border: InputBorder.none,
// //                         hintText: "Password : ",
// //                         hintStyle: TextStyle(fontSize: 19),
// //                         prefixIcon: Icon(Icons.lock),
// //                         suffix: Icon(Icons.visibility),
// //                       ))),
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               // Container(
// //               //     padding:
// //               //         const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
// //               //     decoration: BoxDecoration(
// //               //         color: Colors.purple[100],
// //               //         borderRadius: BorderRadius.circular(66)),
// //               //     width: 266,
// //               //     child: TextField(
// //               //         onChanged: (value) {
// //               //           phone = value;
// //               //         },
// //               //         decoration: InputDecoration(
// //               //           border: InputBorder.none,
// //               //           hintText: "phone : ",
// //               //           hintStyle: TextStyle(fontSize: 20),
// //               //           prefixIcon: Icon(Icons.call),
// //               //         ))),
// //               // const SizedBox(
// //               //   height: 10,
// //               // ),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   setState(() {
// //                     showSpinner = true;
// //                   });

// //                   try {
// //                     var User = await auth.createUserWithEmailAndPassword(
// //                         email: email, password: password);
// //                     print(User.user!.uid);
// //                     FirebaseFirestore.instance
// //                         .collection('users')
// //                         .doc(User.user!.uid)
// //                         .set({
// //                       'username': name,
// //                       'email': email,
// //                       'password': password,
// //                       // 'phone': phone,
// //                     });

// //                     Navigator.pushNamed(context, '/');
// //                     setState(() {
// //                       showSpinner = false;
// //                     });
// //                   } catch (e) {
// //                     print(e);
// //                   }
// //                 },
// //                 style: ButtonStyle(
// //                   backgroundColor: MaterialStateProperty.all(Colors.black),
// //                   padding: MaterialStateProperty.all(
// //                       const EdgeInsets.symmetric(horizontal: 99, vertical: 15)),
// //                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(66))),
// //                 ),
// //                 child: const Text(
// //                   "Register",
// //                   style: TextStyle(fontSize: 27),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 30,
// //               ),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   const Text(
// //                     "Do  have an account?",
// //                     style: TextStyle(color: Colors.black, fontSize: 22),
// //                   ),
// //                   TextButton(
// //                       onPressed: () {
// //                         Navigator.pushNamed(context, '/');
// //                       },
// //                       child: const Text("login",
// //                           style: TextStyle(color: Colors.white, fontSize: 22)))
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// Row(
//                       children: [
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.white,
//                           ),
//                           child: Column(
//                             children: [
//                               Container(
//                                 child: Column(
//                                   children: [
//                                     ElevatedButton(
//                                         onPressed: () {},
//                                         child:
//                                             Icon(Icons.heart_broken, size: 120)),
//                                                                                       SizedBox(height: 5,),

//                                     Text(
//                                       "Cardiologist",
//                                       style: TextStyle(fontSize: 20),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.white,
//                           ),
//                           child: Column(children: [
//                             Container(
//                               child: Column(
//                                 children: [
//                                   ElevatedButton(
//                                       onPressed: () {},
//                                       child: Icon(Icons.earbuds_battery_outlined,
//                                           size: 120)),
//                                                                                     SizedBox(height: 5,),

//                                   Text(
//                                     "Dentist",
//                                     style: TextStyle(fontSize: 20),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ]),
//                         ),
//                         SizedBox(
//                           width: 3,
//                         ),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.white,
//                           ),
//                           child: Column(children: [
//                             Container(
//                               child: Column(
//                                 children: [
//                                   ElevatedButton(
//                                       onPressed: () {},
//                                       child: Icon(Icons.remove_red_eye_outlined,
//                                           size: 120)),
//                                           SizedBox(height: 5,),
//                                   Text(
//                                     "Eye Special",
//                                     style: TextStyle(fontSize: 20),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ]),
//                         ),
//                           SizedBox(
//                           width: 3,
//                         ),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.white,
//                           ),
//                           child: Column(children: [
//                             Container(
//                               child: Column(
//                                 children: [
//                                   ElevatedButton(
//                                       onPressed: () {},
//                                       child: Icon(Icons.wheelchair_pickup,
//                                           size: 120)),
//                                           SizedBox(height: 5,),
//                                   Text(
//                                     "Orthopaedic",
//                                     style: TextStyle(fontSize: 20),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ]),
//                         ),

//                             SizedBox(
//                           width: 3,
//                         ),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.white,
//                           ),
//                           child: Column(children: [
//                             Container(
//                               child: Column(
//                                 children: [
//                                   ElevatedButton(
//                                       onPressed: () {},
//                                       child: Icon(Icons.baby_changing_station,
//                                           size: 120)),
//                                           SizedBox(height: 5,),
//                                   Text(
//                                     "Paediatrician",
//                                     style: TextStyle(fontSize: 20),
//                                   )
//                                 ],
//                               ),
// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Ressetpassword extends StatefulWidget {
  const Ressetpassword({super.key});

  @override
  State<Ressetpassword> createState() => _RessetpasswordState();
}

class _RessetpasswordState extends State<Ressetpassword> {
  final auth = FirebaseAuth.instance;
  var showpass = true;
  late String email;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            )),
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.yellow, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/cover.jpg'),
                SizedBox(
                  height: 30,
                ),
                const Text(
                  "Enter your email to reset password",
                  style: TextStyle(color: Colors.yellow, fontSize: 21),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(66)),
                    width: 266,
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        hintText: 'Enter your Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.yellow,
                        ),
                        hintStyle: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      var User = await auth.sendPasswordResetEmail(email: email);
                      Navigator.pushNamed(context, '/SignIn');
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 99, vertical: 15)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(66))),
                  ),
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(fontSize: 20, color: Colors.yellow),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
