
import 'package:flutter/material.dart';

import '../models/livro.dart';

class Detalhes extends StatelessWidget {
  final Livro livro;
  const Detalhes({
    required this.livro,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(livro.titulo),
      ),
      body: const Center(
        child: Text('Detalhes do livro!'),
      ),
    );
  }
}