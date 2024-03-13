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
  // Início método para Salvar/Atualizar os dados do livro.
  salvar(Livro livro) async {
    debugPrint(livro.codigo);
    if (livro.codigo != null ) {
              http.patch(
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
 
  
    } else {
      _bdLivros.add(
        Livro(
          uid: livro.uid,
          titulo: livro.titulo,
          autor: livro.autor,
          genero: livro.genero,
          qtdPaginas: livro.qtdPaginas,
          metaDia: livro.metaDia,
          status: livro.status,
          pagLidas: 0,
        ),
      );

      await http.post(
        Uri.parse('$url/livros.json?auth=$_token'),
        body: jsonEncode({
          'uid': livro.uid,
          'titulo': livro.titulo,
          'autor': livro.autor,
          'genero': livro.genero,
          'pagLidas': 0,
          'qtdPaginas': livro.qtdPaginas,
          'metaDia': livro.metaDia,
          'status': livro.status,
        }),
      );

    
    }
    getDados();
    notifyListeners();
  }
  // Fim método para Salvar/Atualizar os dados do livro.

  Future<void> getDados() async {
    _bdLivros.clear();

    try {
      final response =
          await http.get(Uri.parse('$url/livros.json?auth=$_token'));

      Map<String, dynamic> json = jsonDecode(response.body);

      json.forEach(
        (codLivro, livro) {
  
       if (json[codLivro]['uid'] == _uid) { 
          _bdLivros.add(
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
        }
      );

    } catch (e) {
      return;
    }
  }

  Future<void> addPagLida(int? qtd, Livro livro) async {
    var pagL = 0;

    bdLivros.forEach((element) {
      if (element.codigo == livro.codigo && element.uid == _uid) {
        if ((element.pagLidas + qtd!) >= element.qtdPaginas) {
          pagL = element.qtdPaginas;
          element.pagLidas = pagL;
        } else {
          pagL = element.pagLidas + qtd;
          element.pagLidas = pagL;
        }
      }
    });

    await http.patch(
      Uri.parse('$url/livros/${livro.codigo}.json?auth$_token'),
      body: jsonEncode(
        {'pagLidas': pagL},
      ),
    );

    notifyListeners();
  }
}
