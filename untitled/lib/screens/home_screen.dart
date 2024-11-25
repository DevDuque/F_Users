import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../controller/user_provider.dart';

import 'edit_user.dart';

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
        title: Text(
          'Usuários Registrados',
          style: Theme.of(context).appBarTheme.titleTextStyle
        ),

        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false
      ),

      body: ListView.builder(

        itemCount: userProvider.users.length,
        itemBuilder: (context, index) {
          final currentUser = userProvider.users[index];

          return ListTile(
            title: Text(currentUser.nome, style: Theme.of(context).textTheme.titleLarge),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 20),

                Text(
                  'Telefone: ${currentUser.telefone}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),

                const SizedBox(height: 4),

                Text(
                  'Email: ${currentUser.email}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),

                const SizedBox(height: 4),

                Text(
                  'Frase: ${getRandomPhrase()}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),

            onTap: () {
              if (currentUser.id == user.id) {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserScreen(user: currentUser),
                  ),
                );

              } else {
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
