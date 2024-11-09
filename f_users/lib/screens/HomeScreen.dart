import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math'; // Para gerar frases aleatórias

import '../controller/UserProvider.dart';
import '../model/UserModel.dart';

import './EditUserScreen.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Array de frases aleatórias
    final List<String> phrases = [
      'A vida é uma jornada, aproveite cada momento.',
      'Seja a mudança que você deseja ver no mundo.',
      'O futuro pertence àqueles que acreditam na beleza de seus sonhos.',
      'A felicidade não é um destino, é uma forma de viajar.',
    ];

    // Função para obter uma frase aleatória
    String getRandomPhrase() {
      final random = Random();
      return phrases[random.nextInt(phrases.length)];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários Registrados'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: userProvider.users.length,
        itemBuilder: (context, index) {
          final currentUser = userProvider.users[index];

          // Coloca o usuário logado no topo da lista
          if (currentUser.id == user.id) {
            return ListTile(
              title: Text(currentUser.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Telefone: ${currentUser.telefone}'),
                  Text('Email: ${currentUser.email}'),
                  Text('Frase: ${getRandomPhrase()}'),
                ],
              ),
              onTap: () {
                // Editar os dados do usuário logado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserScreen(user: currentUser),
                  ),
                );
              },
            );
          }

          // Exibe os outros usuários abaixo
          return ListTile(
            title: Text(currentUser.nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Telefone: ${currentUser.telefone}'),
                Text('Email: ${currentUser.email}'),
                Text('Frase: ${getRandomPhrase()}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
