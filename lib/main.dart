import 'package:flutter/material.dart';
import 'package:wallpaperapp/view/screens/category.dart';
import 'package:wallpaperapp/view/screens/homescreen.dart';
import 'package:wallpaperapp/view/screens/search.dart';
import 'package:wallpaperapp/view/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading=true;
  splashscreen()
  {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading=false;
      });
       } );
  }
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    splashscreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:isLoading?SplashScreen():HomeScreen(),
    );
  }
}

