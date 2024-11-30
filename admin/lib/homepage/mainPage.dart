import 'package:admin/Food/AddFood.dart';
import 'package:admin/Food/AddStaff.dart';
import 'package:admin/User%20Details%20And%20Update/userProfile.dart';
import 'package:admin/homepage/homePage.dart';
import 'package:admin/myAppointents/myAppointmentsPageAll.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget> _pages = [ HomePage(),AddStaff(),AddFood(),MyAppointmentsAll(),UserProfile()];

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              ),
            ],
          ),
          child: SafeArea(
            child:Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: GNav(
      curve: Curves.easeOutExpo,
      rippleColor: Colors.grey,
      hoverColor: Colors.grey,
      haptic: true,
      tabBorderRadius: 20,
      gap: 4,
      activeColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: Duration(milliseconds: 400),
      tabBackgroundColor: Color.fromARGB(255, 238, 220, 88),
      textStyle: TextStyle(
        color: Colors.black,
      ),
      mainAxisAlignment: MainAxisAlignment.center, // لتوسيط الأزرار
      tabs: [
        GButton(
          iconSize: _selectedIndex != 0 ? 28 : 25,
          icon: _selectedIndex == 0 ? Icons.fastfood: Icons.fastfood,
          text: 'Home',
          iconColor: Color.fromARGB(255, 238, 220, 88),
          onPressed: () {
            _onItemTapped(0); // تحديث الـ index
          },
        ),
          GButton(
          iconSize: _selectedIndex != 0 ? 28 : 25,
          icon: _selectedIndex == 0 ? Icons.person_add: Icons.person_add,
          text: 'Staff',
          iconColor: Color.fromARGB(255, 238, 220, 88),
          onPressed: () {
            _onItemTapped(0); // تحديث الـ index
          },
        ),
        GButton(
          iconSize: _selectedIndex != 1 ? 28 : 25,
          icon: _selectedIndex == 1 ? Icons.add : Icons.fastfood,
          text: 'Addfood',
          iconColor: Color.fromARGB(255, 238, 220, 88),
          onPressed: () {
            _onItemTapped(1); // تحديث الـ index
          },
        ),
          GButton(
          iconSize: _selectedIndex != 1 ? 28 : 25,
          icon: _selectedIndex == 1 ? Icons.book_online : Icons.book_online,
          text: 'Appointments',
          iconColor: Color.fromARGB(255, 238, 220, 88),
          onPressed: () {
            _onItemTapped(1); // تحديث الـ index
          },
        ),
          GButton(
          iconSize: _selectedIndex != 1 ? 28 : 25,
          icon: _selectedIndex == 1 ? Icons.people : Icons.people,
          text: 'Profile',
          iconColor: Color.fromARGB(255, 238, 220, 88),
          onPressed: () {
            _onItemTapped(1); // تحديث الـ index
          },
        ),
      ],
      selectedIndex: _selectedIndex,
      onTabChange: _onItemTapped,
    ),
  ),
),

          ),
        ),
      ),
    );
  }
}
