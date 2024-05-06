import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosco_pbp/app_data.dart';
import 'package:rosco_pbp/player.dart';

import 'dart:async'; // Importa este paquete para utilizar Timer

class GameInfoScreen extends StatefulWidget {
  final Player player1;
  final Player player2;

  const GameInfoScreen({
    Key? key,
    required this.player1,
    required this.player2,
  }) : super(key: key);

  @override
  _GameInfoScreenState createState() => _GameInfoScreenState();
}

class _GameInfoScreenState extends State<GameInfoScreen> {
  late Timer _timer; // Define un Timer para ejecutar el método fetchGameInfo

  @override
  void initState() {
    super.initState();
    // Inicia el temporizador para ejecutar fetchGameInfo cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      Provider.of<AppData>(context, listen: false).fetchGameInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Cancela el temporizador cuando el widget se elimina del árbol de widgets
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jugador 1',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Nombre: ${widget.player1.name}'),
                  Text('Puntuación: ${widget.player1.score}'),
                ],
              ),
            ),
            SizedBox(width: 16), // Espacio entre las columnas
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jugador 2',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Nombre: ${widget.player2.name}'),
                  Text('Puntuación: ${widget.player2.score}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
