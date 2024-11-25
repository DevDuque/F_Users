import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../controller/user_provider.dart';

import '../theme/colors.dart';

class EditUserScreen extends StatelessWidget {
  final UserModel user;

  const EditUserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final nomeController = TextEditingController(text: user.nome);
    final emailController = TextEditingController(text: user.email);
    final telefoneController = TextEditingController(text: user.telefone);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.textColor,

          onPressed: () => Navigator.pop(context),
        ),

        title: Text('Editar Usuário', style: Theme.of(context).appBarTheme.titleTextStyle),
        backgroundColor: AppColors.backgroundColor,

        actions: [

          IconButton(
            icon: const Icon(Icons.delete),
            color: AppColors.primaryColor,

            onPressed: () async {
              // Exibir um diálogo de confirmação antes de deletar o usuário
              final shouldDelete = await showDialog<bool>(

                context: context,
                builder: (BuildContext context) {

                  return AlertDialog(

                    title: const Text('Confirmar Exclusão'),
                    content: const Text('Tem certeza que deseja excluir este usuário?'),

                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancelar', style: Theme.of(context).textTheme.displayMedium),
                      ),

                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Excluir', style: Theme.of(context).textTheme.titleMedium),
                      ),

                    ],
                  );
                },
              ) ??
                  false;

              if (shouldDelete) {
                // Deletar usuário
                Provider.of<UserProvider>(context, listen: false).deleteUser(user);

                // Voltar à tela anterior após deletar
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de Nome
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome', style: Theme.of(context).textTheme.labelMedium),

                const SizedBox(height: 16),

                TextField(
                  controller: nomeController,

                  style: const TextStyle(color: AppColors.textColor),

                  decoration: const InputDecoration(hintText: 'Digite seu nome'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Campo de Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Email', style: Theme.of(context).textTheme.labelMedium),

                const SizedBox(height: 16),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  style: const TextStyle(color: AppColors.textColor),

                  decoration: const InputDecoration(hintText: 'Digite seu email'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Campo de Telefone
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Telefone', style: Theme.of(context).textTheme.labelMedium),

                const SizedBox(height: 16),

                TextField(
                  controller: telefoneController,
                  keyboardType: TextInputType.phone,

                  style: const TextStyle(color: AppColors.textColor),

                  decoration: const InputDecoration(hintText: 'Digite seu telefone'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Botão para salvar as alterações
            ElevatedButton(
              onPressed: () {
                final updatedUser = user.copyWith(
                  nome: nomeController.text,
                  email: emailController.text,
                  telefone: telefoneController.text,
                );

                // Atualizar usuário no Provider
                Provider.of<UserProvider>(context, listen: false)
                    .updateUser(updatedUser);

                // Voltar para a tela anterior
                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,

                minimumSize: const Size(double.infinity, 50),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              child: Text('Salvar', style: Theme.of(context).textTheme.displayMedium),
            ),
          ],
        ),
      ),
    );
  }
}
