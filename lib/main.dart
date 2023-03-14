import 'dart:js';

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
      home: AnunciosScreen(),
    );
  }
}

class AnunciosScreen extends StatefulWidget {
  @override
  _AnunciosScreenState createState() => _AnunciosScreenState();
}

class _AnunciosScreenState extends State<AnunciosScreen> {
  List<Anuncio> anuncios = [];

  @override
  void initState() {
    super.initState();
    _lerJson();
  }

  Future<String> _carregarJson() async {
    return await rootBundle.loadString('assets/anuncios.json');
  }

  Future<void> _lerJson() async {
    String jsonString = await _carregarJson();
    final lista = json.decode(jsonString) as List;
    setState(() {
      anuncios = lista.map((e) => Anuncio.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = anuncios
        .map(
          (anuncio) => buildCard(anuncio, context),
        )
        .toList();

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

Widget buildCard(Anuncio anuncio, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child:GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder:(context) => DetalhesAnuncioScreen(anuncio: anuncio,),),);
      },
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
    ),
  );
  
}

class DetalhesAnuncioScreen extends StatelessWidget {
  final Anuncio anuncio;

  DetalhesAnuncioScreen({required this.anuncio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(anuncio.descricao),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              anuncio.imagemURL,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              anuncio.descricao,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              anuncio.valor,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              anuncio.dataHoraLocal,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

