import 'package:admin/User%20Details%20And%20Update/updateUserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  List labelName = [
    // 'ID',
    'Name',
    'Email',
    'PhoneNumber',
    'Bio',
  ];

  List value = [
    // 'id',
    'name',
    'email',
    'phoneNumber',
    'bio',
  ];

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
        elevation: 2,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.yellow,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'User Settings And Update',
          style: GoogleFonts.lato(
              color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Admin')
              .doc(user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var userData = snapshot.data;
            return ListView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                4,
                (index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateUserDetails(
                                    label: labelName[index],
                                    field: value[index],
                                  )));
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        height: MediaQuery.of(context).size.height / 14,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              labelName[index],
                              style: GoogleFonts.lato(
                                color: Colors.yellow,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userData?[value[index]]?.isEmpty ?? true
                                  ? 'Not Added'
                                  : userData?[value[index]],
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
