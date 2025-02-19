import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:users/AuthFirebase/signingoogle.dart';
import 'package:users/homepage/mainPage.dart';
import 'package:users/model/patient_model.dart';

// شاشة المصادقة
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  User? _user;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
    _getUser();
  }

  // تسجيل الدخول باستخدام Google
  Future<void> _signInWithGoogle() async {
    try {
      User? user = await _authService.signInWithGoogle();
      setState(() {
        _user = user;
      });
    } catch (error) {
      _showErrorDialog('Failed to sign in with Google: $error');
    }
  }

  // تحديث بيانات المستخدم بعد تسجيل الدخول باستخدام Google
  Future<void> _updatePatientData() async {
    if (_user == null) return;

    if (_passwordController.text != _passwordConfirmController.text) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    Users updatedPatient = Users(
      email: _user!.email!,
      id: _user!.uid,
      name: _user!.displayName ?? 'No Name',
      phoneNumber: _phoneController.text,
      imageUrl: _user!.photoURL ?? '',
      bio: _bioController.text,
    );

    try {
      await _authService.updatePatientData(updatedPatient);
      _showSuccessDialog('Patient data updated successfully');
    } catch (error) {
      _showErrorDialog('Failed to update patient data: $error');
    }
  }

  // إظهار رسائل الخطأ
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(
                        // currentUserId: user.uid,
                        )), // التوجيه إلى الصفحة الجديدة
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // إظهار رسالة النجاح
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(
                        // currentUserId: patient!.id,
                        )), // التوجيه إلى الصفحة الجديدة
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // title: Text(
        //   'Login',
        //   style: TextStyle(color: Colors.yellow, fontSize: 25),
        // ),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          // لتجنب مشاكل المساحة عند فتح لوحة المفاتيح
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // المحاذاة عموديًا
            crossAxisAlignment: CrossAxisAlignment.center, // المحاذاة أفقيًا
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: _signInWithGoogle,
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(color: Colors.yellow, fontSize: 30),
                ),
              ),
              if (_user != null) ...[
                SizedBox(height: 20),
                Text('Logged in as: ${_user!.displayName ?? _user!.email}'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20), // إضافة مسافة جانبية
                  child: Column(
                    children: [
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      TextField(
                        controller: _passwordConfirmController,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                      ),
                      TextField(
                        controller: _bioController,
                        decoration: InputDecoration(labelText: 'Bio'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updatePatientData,
                  child: Text('Save Additional Data'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
