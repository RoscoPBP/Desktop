import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';
import 'select_language_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await Provider.of<AppData>(context, listen: false).getLanguages();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SelectLanguageScreen()),
            );
          },
          child: Text('Ver diccionarios'),
        ),
      ),
    );
  }
}
