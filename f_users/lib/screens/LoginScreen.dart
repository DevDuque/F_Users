import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';

import '../theme/colors.dart';

import './SignScreen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

              SizedBox(height: 40),

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
                  SizedBox(height: 8),
                  TextField(
                    style: TextStyle(color: AppColors.textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textColor.withOpacity(0.2),
                      border: OutlineInputBorder(),
                      hintText: 'Digite seu email',
                      hintStyle: TextStyle(
                          color: AppColors.textColor.withOpacity(0.5)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Campo de Senha
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Senha',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: AppColors.textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textColor.withOpacity(0.2),
                      border: OutlineInputBorder(),
                      hintText: 'Digite sua senha',
                      hintStyle: TextStyle(
                          color: AppColors.textColor.withOpacity(0.5)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              // Botão de Login
              ElevatedButton(
                onPressed: () {
                  // Implementar a lógica do login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),

              SizedBox(height: 20), // Espaço entre o botão e o link

              // Link horizontal com RichText
              RichText(
                text: TextSpan(
                  text: 'Não tem conta? ', // Primeira parte da frase
                  style: TextStyle(
                    color: AppColors.textColor, // Cor padrão
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Clique Aqui', // Segunda parte da frase
                      style: TextStyle(
                        color: AppColors.secondaryColor, // Cor do link
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navegar para a tela de SignIn
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
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
