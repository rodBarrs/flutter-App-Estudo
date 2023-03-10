import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(AppOLX());
}

class AppOLX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  children: [
                    buildCard(
                      'https://docs.flutter.dev/assets/images/dash/Dash.png',
                      'Mascote pelúcia Dart',
                      'R\$ 94.452,33',
                      '05 December 00:40, Jardim Verão',
                    ),
                    buildCard(
                      'https://m.media-amazon.com/images/I/815bYNT+p8L._AC_SX425_.jpg',
                      'Mascote pelúcia PHP',
                      'R\$ 2,24',
                      '21 de Maio 15:24, Cidade Nova 8',
                    ),
                    buildCard(
                      'https://images.unsplash.com/photo-1618401479427-c8ef9465fbe1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1143&q=80',
                      'Mascote pelúcia GitHub',
                      'R\$ 120,17',
                      '05 dezembro 21:12, Icoaraci',
                    ),
                  ],
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

Widget buildCard(String imageUrl, String descricao, String preco, String dataHoraLocal) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  descricao,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  preco,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                Text(
                  dataHoraLocal,
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
