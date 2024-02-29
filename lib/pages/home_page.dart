import 'package:flutter/material.dart';
import 'package:guialeitura/components/listagem_livros.dart';
import 'package:guialeitura/components/menu_lateral.dart';

import 'package:guialeitura/components/modal_cadastro/modal_cadastro.dart';
import 'package:guialeitura/dados/bd_livros.dart';
import 'package:guialeitura/models/livro.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var appBar = AppBar(
  leading: Builder(
    builder: (context) => IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
          size: 30,
        )),
  ),
  centerTitle: false,
  title: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:  [
      Text(
        'Guia de Leitura',
        style: TextStyle(
            color: Colors.black, fontFamily: 'HedvigLetter', fontSize: 26),
        textAlign: TextAlign.right,
      ),
      SizedBox(width: 15),
      Icon(
        Icons.school_outlined,
        size: 30,
        color: Colors.black,
      )
    ],
  ),
  elevation: 0,
  backgroundColor: Colors.amber,
);

class _MyHomePageState extends State<MyHomePage> {
  openModalCadastro(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const ModalCadastro(),
    );
  }
 
  bool isLoad = true;

  @override
  void initState() {
    Provider.of<BdLivros>(context, listen: false).getDados().then((value) {setState(() {
      isLoad = false;
    });});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Livro> listagem = Provider.of<BdLivros>(context).bdLivros;

    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        child: const MenuLateral(),
      ),
      appBar: appBar,
      body: isLoad?  const Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          CircularProgressIndicator(),
          SizedBox(height: 10,),
          Text('Loading...')
        ],
      ),): 
       listagem.isEmpty || listagem.toString() == '[]'
          ? const Center(
              child: Text('Nenhum Livro cadastrado'),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListagemLivros(listagem: listagem),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => openModalCadastro(context),
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
