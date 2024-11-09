import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';
import './SignScreen.dart';
import './HomeScreen.dart';
import '../controller/UserProvider.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo SVG
              SvgPicture.asset(
                'lib/assets/images/logo.svg',
                width: 150,
                height: 150,
              ),

              const SizedBox(height: 40),

              // Campo de Email
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

              // Botão de Login
              ElevatedButton(
                onPressed: () {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  final user =
                      userProvider.findUserByEmail(emailController.text);

                  if (user.email.isNotEmpty &&
                      user.senha == senhaController.text) {
                    // Login bem-sucedido, navegar para a HomeScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(user: user),
                      ),
                    );
                  } else {
                    // Exibir um erro, se o login falhar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Email ou senha incorretos')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.backgroundColor,
                  ),
                ),
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
                          // Navegar para a tela de SignIn
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
