import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  String jsonString = 
  List<dynamic> jsonList = jsonDecode(jsonString);
  runApp(AppOLX());
}

class AppOLX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OLX Leal',
      home: Scaffold(
          appBar: AppBar(
            title: Text('OLX LEAL'),
            centerTitle: true,
            backgroundColor: Colors.purple,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          ),
          body: SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          right: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ))),
                  width: 160.0,
                  child: const Center(
                      child: Text(
                    'Região de Venda',
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          right: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ))),
                  width: 160.0,
                  child: const Center(
                      child: Text(
                    'Categoria',
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          right: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ))),
                  width: 160.0,
                  child: const Center(
                      child: Text(
                    'Filtro',
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                  )),
                ),
              ],
            ),
          )),
    );
  }
}

class meuCard extends StatelessWidget {
  final int id;
  final String imagemURL;
  final String descricao;
  final String valor;
  final String dataEHora;
  final String local;

  meuCard({
    required this.id,
    required this.imagemURL,
    required this.descricao,
    required this.dataEHora,
    required this.local,
    required this.valor,
  });

  factory meuCard.fromJson(Map<String, dynamic> json) {
    return meuCard(
      id: json['id'],
      imagemURL: json['imagemURL'],
      descricao: json['descricao'],
      valor: json['valor'],
      dataEHora: json['dataEHora'],
      local: json['local'],
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [Image.asset(imagemURL)]),
    );
  }
}
