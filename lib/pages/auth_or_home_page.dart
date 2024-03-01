import 'package:flutter/material.dart';
import 'package:guialeitura/auth/auth_page.dart';
import 'package:guialeitura/models/auth.dart';
import 'package:guialeitura/pages/home_page.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context); 
    debugPrint(auth.isAuth.toString());
    return auth.isAuth? const MyHomePage(): const AuthPage();
  }
}