// GET cantidad de palabras del diccionario
// con la cantidad de palabras la divido entre 20 o 50 (num de palabras por hojas)
// con el numero obtenido creo una especie de navegador por hojas
// por defecto como el navegador estara en el 1, hara un POST
// {
//    "cantidad": 30
//    "pagina" : 20
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';

class DictionaryScreen extends StatefulWidget {
  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  TextEditingController _pageController = TextEditingController();
  List<String> _dictionaryWords = [];

  @override
  void initState() {
    super.initState();
    _loadDictionary();
  }

  Future<void> _loadDictionary() async {
    try {
      await Provider.of<AppData>(context, listen: false).postDictionary();

      setState(() {
        _dictionaryWords =
            Provider.of<AppData>(context, listen: false).languageWords[
                    Provider.of<AppData>(context, listen: false).language] ??
                [];
      });
    } catch (error) {
      print('Error loading dictionary: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (Provider.of<AppData>(context).wordCount / 20)
        .ceil(); // Calcular el número total de páginas

    return Scaffold(
      appBar: AppBar(
        title: Text('Dictionary'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _pageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Page',
                  ),
                  style: TextStyle(
                      fontSize: 14.0), // Ajusta el tamaño de la fuente
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  int pageNumber = int.tryParse(_pageController.text) ?? 1;
                  if (pageNumber > totalPages || pageNumber < 1) {
                    // Validar si el número de página es válido
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Invalid page number'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Actualizar el número de página en AppData
                    Provider.of<AppData>(context, listen: false).pagina =
                        pageNumber;

                    // Realizar una nueva solicitud para obtener las palabras de la página especificada
                    await Provider.of<AppData>(context, listen: false)
                        .postDictionary();
                    setState(() {
                      _dictionaryWords =
                          Provider.of<AppData>(context, listen: false)
                                      .languageWords[
                                  Provider.of<AppData>(context, listen: false)
                                      .language] ??
                              [];
                    });
                  }
                },
                child: Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: (_dictionaryWords.length / 4).ceil(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = index * 4;
                        i < (index + 1) * 4 && i < _dictionaryWords.length;
                        i++)
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            _dictionaryWords[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
