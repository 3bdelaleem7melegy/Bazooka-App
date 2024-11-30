// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staff/myAppointentsElHaram/ElHarmPending.dart';

class MyAppointmentsElHaram extends StatefulWidget {
  const MyAppointmentsElHaram({super.key});

  @override
  _MyAppointmentsElHaramState createState() => _MyAppointmentsElHaramState();
}

class _MyAppointmentsElHaramState extends State<MyAppointmentsElHaram> {
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
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('AppointmentsAll')
                .where('Location', isEqualTo: 'El Haram')
                .where('date', isEqualTo: date)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final itemCount = snapshot.data!.size;

              return Text(
                'Total Appointments: $itemCount', // Display the count in the AppBar title
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              );
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
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
                child: ElHarmPending(),
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
