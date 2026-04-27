import 'package:flutter/material.dart';
import 'main_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'IT-Helper',
      home: Scaffold(body: MainPage(null)),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
    ),
  );
}
