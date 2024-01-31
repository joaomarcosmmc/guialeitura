import 'package:flutter/material.dart';
import 'package:guialeitura/components/card_livros.dart';

class ListagemLivros extends StatefulWidget {
  final List listagem;
  const ListagemLivros({required this.listagem, super.key});

  @override
  State<ListagemLivros> createState() => _ListagemLivrosState();
}

class _ListagemLivrosState extends State<ListagemLivros> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: widget.listagem.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CardLivros(
              livro: widget.listagem[index],
            )),
      ),
    );
  }
}
