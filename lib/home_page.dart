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
    AppData appData = Provider.of<AppData>(context, listen: false);
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
                appData.getLanguages();
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
                 bool isInGame = await appData.fetchGameInfo(context);

                if (isInGame) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GameInfoScreen()),
                  );
                } else {
                  print("no se puede ir");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Game not found'),
                        content: Text('Currently there are no games being played'),
                        actions: <Widget>[
                          // Close button
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );

                }
                
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