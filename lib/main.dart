import 'package:flutter/material.dart';
import 'package:quizzy/pages/homePage.dart';
import 'package:quizzy/pages/quiz_screen.dart';
import 'package:quizzy/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => const splash_screen(),
        '/homePage' : (context) => const homePage(),
        '/quiz_screen' : (context) => const quiz_screen(),
      },
    );
  }
}

