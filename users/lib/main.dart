import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:users/AuthFirebase/firebaseAuth.dart';
import 'package:users/AuthFirebase/login_screen.dart';
import 'package:users/AuthFirebase/register_screen.dart';
import 'package:users/homepage/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCokHnhLxdgDCUxTLx3efJoAJst0UPZ0Ps",
        appId: "1:807471763794:android:af4273916e2be434fb6a8b",
        messagingSenderId: "807471763794",
        projectId: "bazookaapp-76ccc",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isDarkMode = false; // حالة الوضع المظلم

  MyApp({super.key});

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    _getUser();

    return MaterialApp(
        theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),

        initialRoute: '/',
        //
        onGenerateRoute: (settings) {
          switch (settings.name) {
            // case '/':
            //   return MaterialPageRoute(builder: (context) =>  SignIn());
            case '/':
              return MaterialPageRoute(
                  builder: (context) => FutureBuilder(
                        future: Future.value(
                            _auth.currentUser), // Wrap in Future.value
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            // إذا كان المستخدم مسجلاً للدخول، انتقل إلى صفحة الدردشة
                            return MainPage();
                          } else {
                            // إذا لم يكن هناك مستخدم، انتقل إلى صفحة تسجيل الدخول
                            return SignIn();
                          }
                        },
                      ));
            case '/login':
              return MaterialPageRoute(
                  builder: (context) => const FireBaseAuth());
            // case '/ChatScreen':
            //   return MaterialPageRoute(builder: (context) => const ChatScreen());
            //   case '/MainPage':
            // return MaterialPageRoute(builder: (context) =>  MainPage());
            // case '/UsersListPage':
            //   return MaterialPageRoute(
            //       builder: (context) => HomeChat(
            //             currentUserId: patient!.id,
            //           ));
            //             case '/AllChatsPage':

            case '/Register':
              return MaterialPageRoute(builder: (context) => const Register());
          }
          return null;
        });
  }
}
