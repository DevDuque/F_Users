import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/UserModel.dart';
import '../controller/UserProvider.dart';

import './EditUserScreen.dart';

import '../theme/colors.dart';

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
        backgroundColor: AppColors.backgroundColor,
      ),
      body: ListView.builder(
        itemCount: userProvider.users.length,
        itemBuilder: (context, index) {
          final currentUser = userProvider.users[index];

          // Coloca o usuário logado no topo da lista
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
              // Se o usuário tentar editar outro usuário, exibe um alerta
              if (currentUser.id == user.id) {
                // Se for o próprio usuário, navega para a tela de edição
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserScreen(user: currentUser),
                  ),
                );
              } else {
                // Caso contrário, exibe um alerta informando que não pode editar
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Atenção'),
                    content: const Text('Você não pode editar esse usuário.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o alerta
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
