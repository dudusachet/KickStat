import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrantes do Grupo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.school,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              const Text(
                'Projeto Integrador VI-B',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'KickStat - Gerenciador de Estatísticas de Futebol Amador',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 40),
              const Text(
                'Integrantes:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Eduardo Romani Sachet', style: TextStyle(fontSize: 16)),
              const Text('Carolina Silveira', style: TextStyle(fontSize: 16)),
              const Text('Anderson Rodrigues', style: TextStyle(fontSize: 16)),
              const Text('Vitor', style: TextStyle(fontSize: 16)),
              const Text('Tomas', style: TextStyle(fontSize: 16)),
              const Text('Artur', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 40),
              const Text(
                'Tecnologias Utilizadas:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Flutter, Dart, Firebase (Auth, Firestore, Analytics), SQLite'),
            ],
          ),
        ),
      ),
    );
  }
}
