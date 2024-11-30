// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staff/myAppointentsElHaram/ElHarmPending.dart';
import 'package:staff/myAppointentsNaserCity/NasrCityPending.dart';
import 'package:staff/myAppointentsShoubra/ShoubraPending.dart';

class MyAppointmentsShoubra extends StatefulWidget {
  const MyAppointmentsShoubra({super.key});

  @override
  _MyAppointmentsNasrCityState createState() => _MyAppointmentsNasrCityState();
}

class _MyAppointmentsNasrCityState extends State<MyAppointmentsShoubra> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Order Confirmation',
              style: TextStyle(
                color: Color.fromARGB(255, 238, 220, 88),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.only(),
              //   child: const MyAppointmentListLabs(),
              // ),
              //   Container(
              //   padding: const EdgeInsets.only(),
              //   child: AppointmentAll(),
              // ),
              Container(
                padding: const EdgeInsets.only(),
                child: Shoubrapending(),
              ),
              // Container(
              //   padding: const EdgeInsets.only(),
              //   child: const myAppointmentListEcho(),
              // ),
              //   Container(
              //   padding: const EdgeInsets.only(),
              //   child: const appointmentarchiveHistoryListt(),
              // ),
            ],
          ),
        ));
  }
}
