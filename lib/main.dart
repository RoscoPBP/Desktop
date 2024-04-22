import 'app_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosco_pbp/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    ),
  );
}
