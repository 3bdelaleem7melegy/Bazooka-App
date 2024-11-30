// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:admin/myAppointents/AppointmentAll.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAppointmentsAll extends StatefulWidget {
  const MyAppointmentsAll({super.key});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointmentsAll> {
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

  DateTime? selectedDate;
  String _dateFormatter(String timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: StreamBuilder<QuerySnapshot>(
          stream: selectedDate == null
              ? FirebaseFirestore.instance
                  .collection('AppointmentsAll')
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('AppointmentsAll')
                  .where(
                    'date',
                    isEqualTo: selectedDate!.toIso8601String().split(
                        'T')[0], // Assuming the date is stored as YYYY-MM-DD
                  )
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
              selectedDate == null
                  ? 'Total Appointments: $itemCount' // Total count when no date is selected
                  : 'Total Appointments: $itemCount', // Count for the selected date
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.yellow),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.clear, color: Colors.red),
            onPressed: () {
              setState(() {
                selectedDate = null; // Clear the selected date
              });
            },
          ),
        ],
      ),
      body: selectedDate == null
          ? Center(
              child: AppointmentAll(),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('AppointmentsAll')
                  .where('date',
                      isEqualTo: selectedDate!.toIso8601String().split(
                          'T')[0]) // Assuming date is stored as YYYY-MM-DD
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final itemCount = snapshot.data!.size;

                return ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
                    return Card(
                      elevation: 2,
                      child: InkWell(
                        onTap: () {},
                        child: ExpansionTile(
                          title: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 270),
                                  child: Text(
                                    'Type of food: ${document['Special']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const SizedBox(
                                  width: 0,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 290),
                                  child: Text(
                                    'Name Food : ${document['FoodName']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const SizedBox(
                                  width: 0,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: 270), // تحديد عرض النص
                                  child: Text(
                                    'Description Food : ${document['description']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: 300), // تحديد عرض النص
                                  child: Text(
                                    'Restaurant location: ${document['Location']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: 270), // تحديد عرض النص
                                  child: Text(
                                    'Your Location: ${document['LocationUser']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: 300), // تحديد عرض النص
                                  child: Text(
                                    'Price Food : ${document['Price']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                          subtitle: Column(children: [
                            Row(children: [
                              const Text(
                                'Date : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _dateFormatter(document['date']),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              // Text(
                              //   _compareDate(document['date']) ? "TODAY" : "",
                              //   style: const TextStyle(
                              //       color: Colors.green,
                              //       fontSize: 18,
                              //       fontWeight: FontWeight.bold),
                              // ),
                            ]),
                            SizedBox(
                              height: 3,
                            ),
                            Row(children: [
                              Text(
                                // "Time: ${_timeFormatter(
                                //   document['date'],
                                // )}",
                                'Time: ${document['time']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                          ]),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20, right: 10, left: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   // "Time: ${_timeFormatter(
                                      //   //   document['date'],
                                      //   // )}",
                                      //   'User ID: ${document['id']}',
                                      //   style: const TextStyle(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      Text(
                                        "User ID: " + document['id'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "User Name: " + document['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // "Time: ${_timeFormatter(
                                        //   document['date'],
                                        // )}",
                                        'User Number: ${document['PhoneNumber']}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // IconButton(
                                  //   tooltip: 'Delete Appointment',
                                  //   icon: const Icon(
                                  //     Icons.delete,
                                  //     color: Colors.red,
                                  //   ),
                                  //   onPressed: () {
                                  //     print(">>>>>>>>>${document.id}");
                                  //     _documentID = document.id;
                                  //     showAlertDialog(
                                  //         context); // ظهور نافذة التأكيد
                                  //   },
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
