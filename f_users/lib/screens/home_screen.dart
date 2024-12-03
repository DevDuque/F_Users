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
    // Recarrega a lista de usuários sempre que a tela for criada
    Future.delayed(Duration.zero, () {
      context.read<UserProvider>().fetchUsers();
    });

    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Usuários Registrados',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            backgroundColor: AppColors.backgroundColor,
            iconTheme: IconThemeData(color: AppColors.textColor),
            automaticallyImplyLeading: true,
          ),
          body: ListView.builder(
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              final currentUser = userProvider.users[index];

              return Column(
                children: [
                  ListTile(
                    title: Text(
                      currentUser.nome,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
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
                            builder: (context) =>
                                EditUserScreen(user: currentUser),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Atenção'),
                            content: const Text(
                                'Você não pode editar esse usuário.'),
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.4, // 40% à esquerda
                      ),
                      Expanded(
                        flex: 3,
                        child: Divider(
                          color: AppColors.secondaryColor,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // Função para obter uma frase aleatória
  String getRandomPhrase() {
    final List<String> phrases = [
      'A vida é uma jornada, aproveite cada momento.',
      'Seja a mudança que você deseja ver no mundo.',
      'O futuro pertence àqueles que acreditam na beleza de seus sonhos.',
      'A felicidade não é um destino, é uma forma de viajar.',
      'O sucesso é a soma de pequenos esforços repetidos dia após dia.',
      'Acredite em si mesmo e tudo será possível.',
      'A vida começa onde a zona de conforto termina.',
      'Os sonhos não têm limites, só aqueles que colocamos em nossa mente.',
      'O maior erro que você pode cometer é ter medo de cometer erros.',
      'Cada passo que damos nos leva mais perto do nosso propósito.',
      'A persistência é o caminho para alcançar grandes conquistas.'
    ];

    final random = Random();
    return phrases[random.nextInt(phrases.length)];
  }
}
