import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../controller/user_provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../model/user_model.dart';
import 'login_screen.dart';
import '../theme/colors.dart';

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
                  Text('Nome', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nomeController,
                    style: const TextStyle(color: AppColors.textColor),
                    decoration:
                        const InputDecoration(hintText: 'Digite seu nome'),
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
                    style: Theme.of(context).textTheme.labelMedium,
                    decoration:
                        const InputDecoration(hintText: 'Digite seu email'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Campo de Telefone
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Telefone',
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 16),
                  TextField(
                    controller: telefoneController,
                    keyboardType: TextInputType.phone,
                    style: Theme.of(context).textTheme.labelMedium,
                    decoration:
                        const InputDecoration(hintText: 'Digite seu telefone'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Campo de Senha
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Senha', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    controller: senhaController,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.labelMedium,
                    decoration:
                        const InputDecoration(hintText: 'Digite seu senha'),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () async {
                  if (nomeController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      telefoneController.text.isEmpty ||
                      senhaController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Preencha todos os campos!')),
                    );
                    return;
                  }

                  try {
                    final user = UserModel(
                      id: UserModel.generateUUID(),
                      nome: nomeController.text,
                      email: emailController.text,
                      telefone: telefoneController.text,
                      senha: senhaController.text,
                    );

                    // Adiciona o usuário ao provider
                    Provider.of<UserProvider>(context, listen: false)
                        .addUser(user);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Usuário cadastrado com sucesso!')),
                    );

                    // Volta para a tela de login após o cadastro
                    Navigator.pop(context);
                  } catch (error) {
                    // Se o erro for relacionado a e-mail já existente
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error.toString())),
                    );
                    // Volta para a tela de login após o cadastro
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  minimumSize: const Size(double.infinity, 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text('Cadastrar',
                    style: Theme.of(context).textTheme.displayMedium),
              ),

              const SizedBox(height: 20),

              // Link para a tela de login
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
                          Navigator.pushReplacement(
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
