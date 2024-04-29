import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosco_pbp/dictionaty_screen.dart';
import 'app_data.dart'; // Importa tu clase AppData aquí

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener una instancia de AppData
    final appData = Provider.of<AppData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un idioma'),
      ),
      body: ListView(
        children: [
          Center(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: appData.languageWords.keys.map((language) {
                return ElevatedButton(
                  onPressed: () {
                    // Establecer el idioma seleccionado en appData.language
                    appData.language = language;
                    // Llamar al método getDictionaryWordCountCa con el idioma seleccionado
                    appData.getDictionaryWordCountCa().then((_) {
                      // Navegar a la pantalla DictionaryScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DictionaryScreen(),
                        ),
                      );
                    });
                  },
                  child: Text(language),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
