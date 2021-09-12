import 'package:firebase_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        titleSpacing: 10.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
          fontSize: 20.0,
        )),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        selectedItemColor: defaultColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white.withOpacity(.6)));
