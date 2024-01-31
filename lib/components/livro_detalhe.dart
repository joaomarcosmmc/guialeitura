

import 'package:flutter/material.dart';

import '../models/livro.dart';


class LivroDetalhe extends StatefulWidget {

  const LivroDetalhe({

    super.key});

  @override
  State<LivroDetalhe> createState() => _LivroDetalheState();
}

class _LivroDetalheState extends State<LivroDetalhe> {
  @override
  Widget build(BuildContext context) {
    final livro = ModalRoute.of(context)!.settings.arguments as Livro;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(livro.titulo),
      ),
      body: const Center(child:  Text('Detalhes do Livro')),);
  }
}