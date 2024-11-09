import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import '../controller/UserProvider.dart';

import './LoginScreen.dart';
import '../theme/colors.dart';
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
                    keyboardType:
                        TextInputType.emailAddress, // Definindo tipo email
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
                    keyboardType:
                        TextInputType.phone, // Definindo tipo telefone
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
                onPressed: () async {
                  // Verificar se algum campo está vazio
                  if (nomeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nome não pode ser vazio!')),
                    );
                    return;
                  }

                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Email não pode ser vazio!')),
                    );
                    return;
                  }

                  if (telefoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Telefone não pode ser vazio!')),
                    );
                    return;
                  }

                  if (senhaController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Senha não pode ser vazia!')),
                    );
                    return;
                  }

                  // Validar telefone (simples checagem de número)
                  final telefone = telefoneController.text.replaceAll(
                      RegExp(r'\D'),
                      ''); // Remover qualquer coisa que não seja número
                  if (telefone.length < 10 || telefone.length > 11) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Telefone inválido!')),
                    );
                    return;
                  }

                  try {
                    // Criação do usuário com UUID gerado automaticamente
                    final user = UserModel(
                      id: UserModel.generateUUID(), // Gerando o UUID
                      nome: nomeController.text,
                      email: emailController.text,
                      telefone: telefoneController.text,
                      senha: senhaController.text,
                    );

                    // Chama o método de adicionar usuário do Provider
                    await Provider.of<UserProvider>(context, listen: false)
                        .addUser(user);

                    // Mostra um Snackbar para o usuário
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuário cadastrado!')),
                    );
                  } catch (error) {
                    // Logando o erro no console para depuração
                    print('Erro ao cadastrar usuário: $error');

                    // Exibe o Snackbar com o erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Erro ao cadastrar usuário!')),
                    );
                  }
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
