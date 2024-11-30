// ignore_for_file: deprecated_member_use, unused_local_variable, file_names, library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors

import 'package:admin/model/Food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateUserDetails extends StatefulWidget {
  final String label;
  final String field;
  Food food;
  UpdateUserDetails(
      {super.key,
      required this.label,
      required this.field,
      required this.food});

  @override
  _UpdateUserDetailsState createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  final TextEditingController _textcontroller = TextEditingController();
  late FocusNode f1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late String UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
    UserID = user.uid;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 2,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.yellow,
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.yellow,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Foods')
                  .doc(widget.food.id)
                  .snapshots(),
              builder: (context, snapshot) {
                var userData = snapshot.data;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _textcontroller,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    onFieldSubmitted: (String data) {
                      if (widget.label == "Price") {
                        // إذا كان السعر يجب تخزينه كمصفوفة
                        List<String> newPrices =
                            data.split(",").map((e) => e.trim()).toList();
                        _textcontroller.text =
                            newPrices.join(", "); // تحديث النص في الحقل
                        FirebaseFirestore.instance
                            .collection('Foods')
                            .doc(widget.food.id)
                            .update({"Price": newPrices});
                      } else {
                        // إذا كان الحقل عبارة عن نص
                        _textcontroller.text = data;
                        FirebaseFirestore.instance
                            .collection('Foods')
                            .doc(widget.food.id)
                            .update({widget.label: data});
                      }
                    },
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter the ${widget.label}';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              color: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  updateData();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.black.withOpacity(0.9),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateData() {
  if (widget.label == "Price") {
    // إذا كان السعر
    List<String> newPrices = _textcontroller.text.split(",").map((e) => e.trim()).toList();
    FirebaseFirestore.instance
        .collection('Foods')
        .doc(widget.food.id)
        .update({"Price": newPrices});
  } else {
    // إذا كان نصًا
    FirebaseFirestore.instance
        .collection('Foods')
        .doc(widget.food.id)
        .update({widget.label: _textcontroller.text});
  }
}

}
