import 'package:baaby_log/Homepage/HomePage.dart';
import 'package:baaby_log/Homepage/LookHomePage.dart';
import 'package:baaby_log/Mypage/MyPage.dart';
import 'package:baaby_log/Signup/SignUpPage.dart';
import 'package:baaby_log/Signup/FindMyInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Add this import
import 'package:baaby_log/Signup/LogInPage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'navigationBar.dart';
import 'Signup/Splash1.dart';
import 'Signup/SignUpPage2.dart';
import 'Signup/Pregnant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby_Log',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash1(),
      //home: SignUpPage2(),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ko', 'KR'),
      ],
    );
  }
}
