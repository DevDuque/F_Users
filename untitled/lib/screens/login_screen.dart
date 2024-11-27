import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../controller/user_provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';
import 'home_screen.dart';
import 'sign_screen.dart';

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
                        const InputDecoration(hintText: 'Digite seu senha'),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  final user =
                      userProvider.findUserByEmail(emailController.text);

                  if (user != null &&
                      user.email.isNotEmpty &&
                      user.senha == senhaController.text) {
                    // Login successful, navigate to HomeScreen (using push, not pushReplacement)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(user: user),
                      ),
                    );
                  } else {
                    // Display an error if login fails
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
