import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/UserProvider.dart';
import '../model/UserModel.dart';
import '../theme/colors.dart';

class EditUserScreen extends StatelessWidget {
  final UserModel user;

  const EditUserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final nomeController = TextEditingController(text: user.nome);
    final emailController = TextEditingController(text: user.email);
    final telefoneController = TextEditingController(text: user.telefone);
    final senhaController = TextEditingController(text: user.senha);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Editar Usuário'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // Exibir um diálogo de confirmação antes de deletar o usuário
              final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmar Exclusão'),
                        content: const Text(
                            'Tem certeza que deseja excluir este usuário?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Excluir'),
                          ),
                        ],
                      );
                    },
                  ) ??
                  false;

              if (shouldDelete) {
                // Deletar usuário
                Provider.of<UserProvider>(context, listen: false)
                    .deleteUser(user);
                Navigator.pop(context); // Voltar à tela anterior após deletar
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo Nome
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nome',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nomeController,
                  style: const TextStyle(color: AppColors.textColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textColor.withOpacity(0.2),
                    border: const OutlineInputBorder(),
                    hintText: 'Digite seu nome',
                    hintStyle:
                        TextStyle(color: AppColors.textColor.withOpacity(0.5)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Campo Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: AppColors.textColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textColor.withOpacity(0.2),
                    border: const OutlineInputBorder(),
                    hintText: 'Digite seu email',
                    hintStyle:
                        TextStyle(color: AppColors.textColor.withOpacity(0.5)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Campo Telefone
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Telefone',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: telefoneController,
                  style: const TextStyle(color: AppColors.textColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textColor.withOpacity(0.2),
                    border: const OutlineInputBorder(),
                    hintText: 'Digite seu telefone',
                    hintStyle:
                        TextStyle(color: AppColors.textColor.withOpacity(0.5)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Campo Senha
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Senha',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  style: const TextStyle(color: AppColors.textColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textColor.withOpacity(0.2),
                    border: const OutlineInputBorder(),
                    hintText: 'Digite sua senha',
                    hintStyle:
                        TextStyle(color: AppColors.textColor.withOpacity(0.5)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
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
                  senha: senhaController.text,
                );

                // Atualizar usuário no Provider
                Provider.of<UserProvider>(context, listen: false)
                    .updateUser(updatedUser);

                // Voltar para a tela anterior
                Navigator.pop(context);
              },
              child: const Text('Salvar Alterações'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
