import 'package:flutter/material.dart';
import 'package:guialeitura/components/livro_detalhe.dart';
import 'package:guialeitura/dados/bd_livros.dart';
import 'package:guialeitura/pages/home_page.dart';
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
        ChangeNotifierProvider(create: (_) => BdLivros(),)
      ],
      child: MaterialApp(
        
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        title: 'Flutter Demo',
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
        routes: {'/livroDetalhe': (_)=> const LivroDetalhe()},
      ),
    );
  }
}

