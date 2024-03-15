import 'package:flutter/material.dart';
import 'package:guialeitura/components/card_livros.dart';
import 'package:guialeitura/dados/bd_livros.dart';
import 'package:provider/provider.dart';



class ListagemLivrosLidos extends StatelessWidget {
   
    const ListagemLivrosLidos({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BdLivros>(context);
    var listagem = provider.bdLivros.where((element) => element.status == 'finalizado').toList() ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text('Livros Lidos!', style: TextStyle(fontFamily: 'HedvigLetter'),),
      ),
      body: listagem.isEmpty
          ? const Center(
              child: Text('Ainda não há nenhum Livro Lido'),
            )
          : SizedBox(
        child: ListView.builder(
          itemCount: listagem.length,
          itemBuilder: (context, index) =>  Padding(
              padding: const EdgeInsets.all( 8.0),
              child: CardLivros(
                livro: listagem[index],
              )),
        ),
      ),
    );
  }
}
