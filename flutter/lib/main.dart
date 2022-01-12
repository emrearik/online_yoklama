import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_yoklama/screens/landing_page.dart';
import 'package:online_yoklama/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
          title: 'Online Yoklama Sistemi',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: LandingPage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
