import 'package:flutter/material.dart';

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
                  width: 160.0,
                  color: Colors.red,
                  child: const Center(
                  child: Text(
                'Item 1',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
                ),
                Container(
                  width: 160.0,
                  color: Colors.blue,
                  child: const Center(
                  child: Text(
                'Item 2',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
                ),
              ],
            ),
          )),
    );
  }
}
