import 'package:flutter/material.dart';

class Infopage extends StatelessWidget {
  Infopage({Key? key}) : super(key: key);

  static const route = '/Infopage';
  static const routename = 'Infopage';

  @override
  Widget build(BuildContext context) {
    print('${Infopage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(Infopage.routename),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: const Text(
                'Questa applicazione è stata pensata per motivare gli utenti registrati a muoversi, imponendosi degli obiettivi che una volta raggiunti permettono di ottenere dei coupon di sconto in negozi scelti dallo stesso utente sempre tramite app. Questo è stato pensato per far si che si possano selezionare i marchi, che sono presenti in zone limitrofe rispetto a quella in cui si abita'),
          ),
          FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Profilepage');
              },
              child: Icon(Icons.done))
        ],
      ),
    );
  } //build

} //Page