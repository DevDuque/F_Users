import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/LoginScreen.dart';
import './controller/UserProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
