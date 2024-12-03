import 'package:f_users/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'screens/login_screen.dart';
import 'controller/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Para web, inicializa o sqflite_common_ffi_web
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    // Para outras plataformas, continua com a inicialização tradicional
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(home: LoginScreen(), theme: AppTheme.theme),
    );
  }
}
