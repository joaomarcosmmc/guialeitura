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
 
  
  title: const Text(
    'Guia de Leitura',
    style: TextStyle(
        color: Colors.black, fontFamily: 'HedvigLetter', fontSize: 26),
    textAlign: TextAlign.right,
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


  bool isLoading = true;
  List<Livro> listagem = [];

  @override
  void initState() {
     Provider.of<BdLivros>(context, listen: false).getDados().then((value){
      setState(() {
        listagem = [];
        isLoading = false;
    
      });
     }
    
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listagem =[];
     listagem = Provider.of<BdLivros>(context).bdLivros;
   


    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        child: const MenuLateral(),
      ),
      appBar: appBar,
      body: isLoading?  const Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          CircularProgressIndicator(),
          SizedBox(height: 10,),
          Text('Loading...')
        ],
      ),): 
       listagem.isEmpty || listagem.toString() == '[]'
          ?  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                        'Nenhum livro cadastrado.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.error_outline,
                        size: 150,
                        color: Colors.grey[400],
                      )
                  
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListagemLivros(listagem: listagem),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => openModalCadastro(context),
        tooltip: 'Add Livro',
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
