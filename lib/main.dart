import 'package:flutter/material.dart';

import 'package:guialeitura/auth/auth_page.dart';
import 'package:guialeitura/components/livro_detalhe.dart';

import 'package:guialeitura/dados/bd_livros.dart';
import 'package:guialeitura/models/auth.dart';
import 'package:guialeitura/pages/home_page.dart';
import 'package:guialeitura/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BdLivros(),),
        ChangeNotifierProvider(create: (_) => Auth(),)
      ],
      child: MaterialApp(
        
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        title: 'Flutter Demo',
   
        debugShowCheckedModeBanner: false,
        routes: {
          RoutesPage().AUTH : (context)=> const AuthPage(),
          RoutesPage().INICIO: (context)=> const MyHomePage(),
          RoutesPage().LIVRODETALHE: (context)=> const LivroDetalhe(),
          },
      ),
    );
  }
}

