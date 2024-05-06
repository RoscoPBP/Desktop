import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosco_pbp/app_data.dart';
import 'package:rosco_pbp/player.dart';

import 'dart:async'; // Importa este paquete para utilizar Timer

class GameInfoScreen extends StatefulWidget {

  const GameInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GameInfoScreenState createState() => _GameInfoScreenState();
}

class _GameInfoScreenState extends State<GameInfoScreen> {
  late Timer _timer; // Define un Timer para ejecutar el método fetchGameInfo

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
    // Cancela el temporizador cuando el widget se elimina del árbol de widgets
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: false);

    // Inicia el temporizador para ejecutar fetchGameInfo cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      bool noGamePlayed = await Provider.of<AppData>(context, listen: false).fetchGameInfo(context);
      if (noGamePlayed == false) {
        print("se acabo la partida");
        Navigator.pop(context);
      }

    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Info'),
      ),
      body:  Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max, // Ensure the Row takes up all horizontal space
          children: [
            _buildContainer('UUID:', appData.data['UUID']),
            _buildContainer('Start Date:', appData.data['startDate']),
            _buildContainer('Type:', appData.data['type']),
            _buildContainer('Dictionary Code:', appData.data['dictionaryCode']),
            _buildContainer('Letters:', appData.data['letters'].toString()),
          ],
        ),
        const SizedBox(height: 16), // Add some spacing between the Row and the next element
          if (appData.players.isEmpty) // Conditionally show the red or green container
            Container(
              width: 100, // Take up all horizontal space
              height: 100, // Set height as needed
              color: Colors.red,
            )
          else
            Container(
              width: 100, // Take up all horizontal space
              height: 100, // Set height as needed
              color: Colors.green,
            ),

      ],)
      
      
    ),
  ));
  }

  Widget _buildContainer(String label, String data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            data,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
