import 'package:flutter/material.dart';
import 'package:guialeitura/components/card_livros.dart';
import 'package:guialeitura/components/menu_lateral.dart';
import 'package:guialeitura/dados/bd_livros.dart';
import 'package:provider/provider.dart';

class ListagemLeituraFutura extends StatelessWidget {
  const ListagemLeituraFutura({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BdLivros>(context);
    var listagem = provider.bdLivros
        .where((element) => element.status == 'lista')
        .toList();
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        child: const MenuLateral(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          'Futuras Leituras!',
          style: TextStyle(fontFamily: 'HedvigLetter', fontWeight: FontWeight.bold),
        ),
      ),
      body: listagem.isEmpty
          ?  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Ainda não há nenhum livro cadastrado em futuras leituras.', style: TextStyle(fontSize: 20,), textAlign: TextAlign.center,),
                    Icon(
                      Icons.error_outline,
                      size: 150,
                      color: Colors.grey[400],
                    )
                  ],
                ),
              ),
          )
          : SizedBox(
              child: ListView.builder(
                itemCount: listagem.length,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardLivros(
                      livro: listagem[index],
                    )),
              ),
            ),
    );
  }
}
