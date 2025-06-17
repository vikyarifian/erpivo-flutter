import 'package:erpivo/main_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const ERPivoApp());
}

class ERPivoApp extends StatelessWidget {
  const ERPivoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MainPage mainPage = const MainPage();
    // MaterialApp materialApp = MaterialApp(home: mainPage);

    // return materialApp;
    return MaterialApp(
      title: 'ERPivo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/logos/erpivo_logo.png', height: 120),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'ERPivo',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
