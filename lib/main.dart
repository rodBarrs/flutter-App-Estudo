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
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text('OLX LEAL'),
              centerTitle: true,
              backgroundColor: Colors.purple,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
              leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Região de...',
                    ),
                  ),
                  Tab(
                    child: Text('Categoria'),
                  ),
                  Tab(
                    child: Text('Filtro'),
                  )
                ],
              ),
            ),
            body: SizedBox(
              height: 100,
            )),
      ),
    );
  }
}
