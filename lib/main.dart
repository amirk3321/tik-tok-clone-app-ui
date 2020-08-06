import 'package:flutter/material.dart';
import 'package:flutter_tiktok_ui/screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter tik tok',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
