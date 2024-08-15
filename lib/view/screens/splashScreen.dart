import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    child: Image.network("https://w0.peakpx.com/wallpaper/687/168/HD-wallpaper-avengers-logo.jpg"),
    ),
    );
  }
}
