import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/presentation/home/view/home_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCWrL0mNRccj-5sZF_M0IkIDO06nodYztc",
        authDomain: "portfolio-c3769.firebaseapp.com",
        projectId: "portfolio-c3769",
        storageBucket: "portfolio-c3769.firebasestorage.app",
        messagingSenderId: "361649011913",
        appId: "1:361649011913:web:a980ebbed48f8f97382118",
        measurementId: "G-7WP6V3DN26"
    )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio - Saikiran',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );

  }
}


