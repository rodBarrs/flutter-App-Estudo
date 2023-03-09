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
      home: Scaffold(
          appBar: AppBar(
            title: Text('OLX LEAL'),
            centerTitle: true,
            backgroundColor: Colors.purple,
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
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
            child: Container(
          color: Colors.grey[200], // cor de fundo
          child: AnunciosList(), // lista de anúncios
        ), 
          )),
    );
  }
}

class Anuncio {
  final int id;
  final String imagemURL;
  final String descricao;
  final String valor;
  final String dataEHora;
  final String local;

  Anuncio({
    required this.id,
    required this.imagemURL,
    required this.descricao,
    required this.valor,
    required this.dataEHora,
    required this.local,
  });

  factory Anuncio.fromJson(Map<String, dynamic> json) {
    return Anuncio(
      id: json['id'],
      imagemURL: json['imagemURL'],
      descricao: json['descricao'],
      valor: json['valor'],
      dataEHora: json['dataEHora'],
      local: json['local'],
    );
  }
}

Future<List<Anuncio>> carregarAnuncios() async {
  final response = await rootBundle.loadString('lib/anuncios.json');

  final List<dynamic> json = jsonDecode(response);
  return json.map((e) => Anuncio.fromJson(e)).toList();
}

class AnuncioCard extends StatelessWidget {
  final Anuncio anuncio;

  const AnuncioCard({Key? key, required this.anuncio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(anuncio.imagemURL),
          ListTile(
            title: Text(anuncio.descricao),
            subtitle: Text('${anuncio.valor} - ${anuncio.dataEHora}'),
            trailing: Text(anuncio.local),
          ),
        ],
      ),
    );
  }
}

class AnunciosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Anuncio>>(
      future: carregarAnuncios(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final anuncios = snapshot.data!;
          return ListView.builder(
            itemCount: anuncios.length,
            itemBuilder: (context, index) {
              return AnuncioCard(anuncio: anuncios[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar os anúncios'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
