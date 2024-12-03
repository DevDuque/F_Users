import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../controller/user_provider.dart';

import '../theme/colors.dart';

import 'home_screen.dart';
import 'sign_screen.dart';

import '../controller/database_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final senhaController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo com GestureDetector para detectar o LongPress
              GestureDetector(
                onLongPress: () async {
                  // Chama a função para deletar todos os usuários do banco de dados
                  await DatabaseHelper.deleteAllUsers();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Todos os usuários foram deletados')),
                  );
                },
                child: SvgPicture.asset(
                  'lib/assets/images/logo.svg',
                  width: 150,
                  height: 150,
                ),
              ),

              const SizedBox(height: 40),

              // Campo de Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    style: Theme.of(context).textTheme.labelMedium,
                    decoration:
                        const InputDecoration(hintText: 'Digite seu email'),
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
                        const InputDecoration(hintText: 'Digite sua senha'),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () async {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  final user =
                      await userProvider.findUserByEmail(emailController.text);

                  if (user != null && user.senha == senhaController.text) {
                    // Navega para a HomeScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(user: user),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Email ou senha incorretos')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  minimumSize: const Size(double.infinity, 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Entrar',
                    style: Theme.of(context).textTheme.displayMedium),
              ),

              const SizedBox(height: 20),

              // Link para a tela de cadastro
              RichText(
                text: TextSpan(
                  text: 'Não tem conta? ',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignScreen()),
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
