import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:guialeitura/dados/bd.dart';
import 'package:guialeitura/models/livro.dart';
import 'package:http/http.dart' as http;

class BdLivros extends ChangeNotifier {
  final String? _token;
  final String? _uid;
  final List<Livro> _bdLivros;

  BdLivros(this._token, this._uid, this._bdLivros);

  List<Livro> get bdLivros => _bdLivros;
  String url = Bd().urlBd;


  //---------------------------------------
  // INICIO DO MÉTODO SALVAR/ALTERAR LIVRO.
  //---------------------------------------
  Future<void> salvar(Livro livro) async {
    
    if (livro.codigo != null) { // caso o codigo do livro seja não nulo, então entra no laço FOR.
      /*Neste caso usamos uma lista que é constituida pelos dados do banco, mas essa alteração
      ainda não afeta o banco, ela tem o objetivo de agilizar o funcionamento do aplicativo.*/
      
      for (var element in bdLivros) { // Aqui ele irá percorrer toda lista BdLivros.
        if (element.codigo == livro.codigo) {//Buscando pelo livro que está sendo alterado.
          //Quando encontrar o livro, os dados antigos serão substituidos pelo novos dados.
          element.codigo = livro.codigo;
          element.genero = livro.genero;
          element.metaDia = livro.metaDia;
          element.qtdPaginas = livro.qtdPaginas;
          element.uid = livro.uid;
          element.titulo = livro.titulo;
          element.status = livro.status;
          element.autor = livro.autor;
          element.pagLidas = livro.pagLidas;
        }
      }
      notifyListeners();
      
      /*Agora sim, inicia a perssistencia no banco de dados.*/
     await http.patch(
        Uri.parse('$url/livros/${livro.codigo}.json?auth$_token'),
        body: jsonEncode(
          {
            'uid': livro.uid,
            'titulo': livro.titulo,
            'autor': livro.autor,
            'genero': livro.genero,
            'pagLidas': livro.pagLidas,
            'qtdPaginas': livro.qtdPaginas,
            'metaDia': livro.metaDia,
            'status': livro.status,
          },
        ),
      );
    } else { // caso o código do livro seja Nulo, ele irá salvar os dados criando um novo registro.
      /* Como aconteceu na sessão anterior, os dados serão salvos primeiro na lista bdLivros,
      não fazendo alteração no banco de dados. */
      
      /*agora sim inicia a perssistencia no banco de dados.*/
      await http.post(
        Uri.parse('$url/livros.json?auth=$_token'),
        body: jsonEncode({
          'uid': livro.uid,
          'titulo': livro.titulo,
          'autor': livro.autor,
          'genero': livro.genero,
          'pagLidas': livro.pagLidas,
          'qtdPaginas': livro.qtdPaginas,
          'metaDia': livro.metaDia,
          'status': livro.status,
        }),
      ).then((value) {
        var cod = jsonDecode(value.body); 
        
         bdLivros.add(
          Livro(
            codigo: cod['name'],
            uid: livro.uid,
            titulo: livro.titulo,
            autor: livro.autor,
            genero: livro.genero,
            qtdPaginas: livro.qtdPaginas,
            metaDia: livro.metaDia,
            status: livro.status,
            pagLidas: livro.pagLidas,
          ),
        );
      });
    }

    notifyListeners();
  }
  //-------------------------------------
  // FIM DO MÉTODO SALVAR/ALTERAR LIVRO.
  //-------------------------------------

  Future<void> getDados() async {
 
    _bdLivros.clear();
      try {
      final response =
          await http.get(Uri.parse('$url/livros.json?auth=$_token'));
      debugPrint(response.toString());
      Map<String, dynamic> json = jsonDecode(response.body);

      json.forEach((codLivro, livro) {
        if (json[codLivro]['uid'] == _uid) {
          bdLivros.add(
            Livro(
              codigo: codLivro,
              uid: livro['uid'],
              titulo: livro['titulo'],
              autor: livro['autor'],
              genero: livro['genero'],
              pagLidas: livro['pagLidas'],
              qtdPaginas: livro['qtdPaginas'],
              metaDia: livro['metaDia'],
              status: livro['status'],
            ),
          );
        }
        notifyListeners();
      });
    } catch (e) {
      return;
    }
  }

  Future<void> delete(String cod)async{
    await http.delete(
      Uri.parse('$url/livros/$cod.json?auth$_token'),
    ).then((value) => 
    bdLivros.removeWhere((livro) => livro.codigo == cod)
    );
    notifyListeners();
  }

  Future<void> addPagLida(int? qtd, Livro livro) async {
    var pagL = 0;

    for (var element in bdLivros) {
      
      if (element.codigo == livro.codigo && element.uid == _uid) {
        if ((element.pagLidas + qtd!) >= element.qtdPaginas) {
          pagL = element.qtdPaginas;
          element.pagLidas = pagL;
        } else {
          pagL = element.pagLidas + qtd;
          element.pagLidas = pagL;
        }
      }
    }
 

    await http.patch(
      Uri.parse('$url/livros/${livro.codigo}.json?auth$_token'),
      body: jsonEncode(
        {'pagLidas': pagL},
      ),
    );

    notifyListeners();
  }
}
