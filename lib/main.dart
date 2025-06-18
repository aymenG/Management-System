import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'views/LoginForm.dart';

void main() {
   if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    sqfliteFfiInit();
  }
  
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      home: Scaffold(
        body: loginFormWidget(passwordController: _passwordController),
      ),
    );
  }
}
