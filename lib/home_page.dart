import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosco_pbp/game_info_screen.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await Provider.of<AppData>(context, listen: false)
                    .getLanguages();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectLanguageScreen()),
                );
              },
              child: Text('Ver diccionarios'),
            ),
            SizedBox(height: 20), // Espacio entre los botones
            ElevatedButton(
              onPressed: () async {
                await Provider.of<AppData>(context, listen: false)
                    .fetchGameInfo();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameInfoScreen(
                            // Cambia la ruta a GameInfoScreen
                            player1:
                                Provider.of<AppData>(context, listen: false)
                                    .players[0],
                            player2:
                                Provider.of<AppData>(context, listen: false)
                                    .players[1],
                          )),
                );
              },
              child: Text('Seguir partida'),
            ),
          ],
        ),
      ),
    );
  }
}



/*
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

 */