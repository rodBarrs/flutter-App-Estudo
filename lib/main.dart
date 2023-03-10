import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(AppOLX());
}

class AppOLX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    File file = File('lib/anuncios.json');
    String jsonString = file.readAsStringSync();
    List<dynamic> jsonList = json.decode(jsonString);

    List<Anuncio> anuncios = [];
    for (var jsonMap in jsonList) {
      Anuncio anuncio = Anuncio.fromJson(jsonMap);
      anuncios.add(anuncio);
    }

    List<Widget> cards = []; // lista de widgets

    for (var i = 0; i < anuncios.length; i++) {
      Anuncio anuncio = anuncios[i];
      Widget card = buildCard(
        anuncio,
      );
      cards.add(card);
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Anuncio anuncio = Anuncio.fromJson(jsonMap);
    return MaterialApp(
      title: 'OLX Leal',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('OLX Rodrigo'),
            centerTitle: true,
            backgroundColor: Colors.purple,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            bottom: const TabBar(tabs: <Widget>[
              Tab(
                child: Text('Região de...'),
              ),
              Tab(
                child: Text('Categoria'),
              ),
              Tab(
                child: Text('Filtro'),
              )
            ]),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView(
                  children: [...cards],
                ))
              ],
            ),
          ),
          // ignore: prefer_const_constructors

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {},
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                ),
                Column(children: const [
                  Icon(Icons.camera_alt),
                  Text('Anuncie aqui'),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Anuncio {
  final int id;
  final String imagemURL;
  final String descricao;
  final String valor;
  final String dataHoraLocal;

  Anuncio({
    required this.id,
    required this.imagemURL,
    required this.descricao,
    required this.valor,
    required this.dataHoraLocal,
  });

  factory Anuncio.fromJson(Map<String, dynamic> json) {
    return Anuncio(
      id: json['id'],
      imagemURL: json['imagemURL'],
      descricao: json['descricao'],
      valor: json['valor'],
      dataHoraLocal: json['dataHoraLocal'],
    );
  }

  Map<String, dynamic> toJson() => {
        'imagemURL': imagemURL,
        'descricao': descricao,
        'valor': valor,
        'dataHoraLocal': dataHoraLocal,
      };
}

Widget buildCard(Anuncio anuncio) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          Image.network(
            anuncio.imagemURL,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  anuncio.descricao,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  anuncio.valor,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                Text(
                  anuncio.dataHoraLocal,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
