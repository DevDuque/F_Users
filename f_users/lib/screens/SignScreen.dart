import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';
import './LoginScreen.dart';
import '../controller/UserProvider.dart';
import '../model/UserModel.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nomeController = TextEditingController();
    final emailController = TextEditingController();
    final telefoneController = TextEditingController();
    final senhaController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo SVG
              SvgPicture.asset(
                'lib/assets/images/logo.svg',
                width: 150,
                height: 150,
              ),

              const SizedBox(height: 40),

              // Campo de Nome
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nomeController,
                    style: TextStyle(color: AppColors.textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textColor.withOpacity(0.2),
                      border: OutlineInputBorder(),
                      hintText: 'Digite seu nome',
                      hintStyle: TextStyle(
                          color: AppColors.textColor.withOpacity(0.5)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Campo de Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    style: TextStyle(color: AppColors.textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textColor.withOpacity(0.2),
                      border: OutlineInputBorder(),
                      hintText: 'Digite seu email',
                      hintStyle: TextStyle(
                          color: AppColors.textColor.withOpacity(0.5)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Campo de Telefone
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Telefone',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: telefoneController,
                    style: TextStyle(color: AppColors.textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textColor.withOpacity(0.2),
                      border: OutlineInputBorder(),
                      hintText: 'Digite seu telefone',
                      hintStyle: TextStyle(
                          color: AppColors.textColor.withOpacity(0.5)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Campo de Senha
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
                      hintStyle: TextStyle(
                          color: AppColors.textColor.withOpacity(0.5)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Botão de Cadastro
              ElevatedButton(
                onPressed: () {
                  // Criação do usuário com UUID gerado automaticamente
                  final user = UserModel(
                    id: UserModel.generateUUID(), // Gerando o UUID
                    nome: nomeController.text,
                    email: emailController.text,
                    telefone: telefoneController.text,
                    senha: senhaController.text,
                  );

                  // Chama o método de adicionar usuário do Provider
                  Provider.of<UserProvider>(context, listen: false)
                      .addUser(user)
                      .then((_) {
                    // Mostra um Snackbar ou navega para outra tela
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Usuário cadastrado!')));
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao cadastrar usuário!')));
                  });
                },
                child: const Text('Cadastrar'),
              ),

              const SizedBox(height: 20),

              // Link horizontal com RichText
              RichText(
                text: TextSpan(
                  text: 'Já tem conta? ',
                  style: const TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Clique Aqui',
                      style: const TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navegar para a tela de Login
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
