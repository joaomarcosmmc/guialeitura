import 'package:flutter/material.dart';
import 'package:guialeitura/components/modal_cadastro_horizontal.dart';
import 'package:guialeitura/components/modal_cadastro_vertical.dart';
import 'package:guialeitura/dados/bd_livros.dart';
import 'package:guialeitura/models/livro.dart';
import 'package:provider/provider.dart';

class ModalCadastro extends StatefulWidget {

  const ModalCadastro({ super.key});

  @override
  State<ModalCadastro> createState() => _ModalCadastroState();
}

class _ModalCadastroState extends State<ModalCadastro> {
  TextEditingController tituloText = TextEditingController();
  TextEditingController autorText = TextEditingController();
  TextEditingController generoText = TextEditingController();
  TextEditingController paginasText = TextEditingController();
  TextEditingController metaText = TextEditingController();
  TextEditingController statusText = TextEditingController();

  void salvar(Livro livro){
    Provider.of<BdLivros>(context, listen: false).addLivros(livro);
  }
  @override
  Widget build(BuildContext context) {
    var isHorizonal =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return isHorizonal
        ? ModalCadastroHorizontal(
            salvar: salvar,
            tituloText: tituloText,
            autorText: autorText,
            generoText: generoText,
            metaText: metaText,
            paginasText: paginasText,
            statusText: statusText,
          )
        : ModalCadastroVertical(
            salvar: salvar,
            tituloText: tituloText,
            autorText: autorText,
            generoText: generoText,
            metaText: metaText,
            paginasText: paginasText,
            statusText: statusText);
  }
}
