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
            title: Text('OLX LEAL'),
            centerTitle: true,
            backgroundColor: Colors.purple,
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
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
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              'https://docs.flutter.dev/assets/images/dash/Dash.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              child: Column(
                                children: const [
                                  Text(
                                    'Card 1',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Descrição 1',
                                    style: TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                  Text(
                                    'Hora',
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              'https://m.media-amazon.com/images/I/815bYNT+p8L._AC_SX425_.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const Expanded(
                              child: Text('Descrição do card',
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              'https://images.unsplash.com/photo-1618401479427-c8ef9465fbe1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1143&q=80',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const Expanded(
                              child: Text('Descrição do card',
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
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
