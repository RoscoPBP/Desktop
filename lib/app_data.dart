import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rosco_pbp/player.dart';

class AppData extends ChangeNotifier {
  //final String apiUrl = 'http://127.0.0.1:9000';
  final String apiUrl = 'https://roscodrom4.ieti.site';
  Map<String, List<String>> languageWords = {};
  int pagina = 1;
  int cantidad = 20;
  String language = '';
  int wordCount = 0;
  List<Player> players = [];

  // Método para realizar una solicitud GET a la API
  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$apiUrl/$endpoint'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  // YA NO SE USA
  Future<void> getLanguages() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/dictionary/languages'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> languagesData = jsonData['data']['languages'];
        for (dynamic languageData in languagesData) {
          String languageName = languageData['name'];
          languageWords[languageName] = [];
        }
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (error) {
      print('Error fetching languages: $error');
    }
  }

  Future<void> postDictionary() async {
    try {
      Map<String, dynamic> requestBody = {
        'idioma': "ca",
        'cantidad': cantidad,
        'pagina': pagina,
      };
      final response = await postData('api/dictionary/list', requestBody);
      if (response['status'] == 'OK') {
        List<dynamic> pages = response['data']['pages'];
        List<String> palabras =
            pages.map((page) => page['word'].toString()).toList();
        languageWords[language] = palabras;
        /*
        List<dynamic> palabrasList = response['palabras'];
        List<String> palabras = palabrasList.map((e) => e.toString()).toList();
        languageWords[language] = palabras;
        */
        print(languageWords);
      } else {
        throw Exception('Failed to fetch dictionary from API');
      }
    } catch (error) {
      throw Exception('Error fetching dictionary: $error');
    }
  }

  // CREO QUE YA NO SE USA
  Future<void> postDictionaryWordCount(String idioma) async {
    try {
      Map<String, dynamic> requestBody = {'idioma': idioma};
      final response =
          await postData('api/postDictionaryWordCount', requestBody);
      if (response['success'] == true) {
        wordCount = response['numero'];
      } else {
        throw Exception('Failed to fetch dictionary from API');
      }
    } catch (error) {
      throw Exception('Error fetching dictionary: $error');
    }
  }

  Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$apiUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send data to API');
    }
  }

  // GET
  Future<void> getDictionaryWordCountCa() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/dictionary/ca/lenght'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        // Verificar si 'data' está presente y no es nulo
        if (jsonData.containsKey('data') && jsonData['data'] != null) {
          // Acceder al recuento de palabras dentro de 'data'
          int count = jsonData['data']['count'];
          wordCount = count;
          print(wordCount);
        } else {
          throw Exception('Data field is missing or null');
        }
      } else {
        throw Exception('Failed to fetch dictionary word count from API');
      }
    } catch (error) {
      throw Exception('Error fetching dictionary word count: $error');
    }
  }

  Future<void> fetchGameInfo() async {
    try {
      final response = await fetchData('/api/game/data');
      print('Response from API: $response'); // Imprimir la respuesta completa

      // Verificar si 'enPartida' es false
      bool enPartida = response['enPartida'];
      if (!enPartida) {
        throw Exception('No hay partida en curso');
      }

      // Acceder a los datos dentro de 'data'
      final data = response['data'];

      // Acceder a la lista de jugadores dentro de 'data'
      List<dynamic> playerData = data['players'];

      // Mapear los datos de los jugadores a objetos Player
      players = playerData.map((data) => Player.fromJson(data)).toList();

      // Si no hay jugadores, crear jugadores falsos con información vacía
      if (players.isEmpty) {
        players.add(Player(name: '', score: 0)); // Jugador 1 falso
        players.add(Player(name: '', score: 0)); // Jugador 2 falso
      }

      // Notificar a los listeners después de actualizar los datos
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch game info: $error');
    }
  }
}
