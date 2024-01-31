import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:guialeitura/models/livro.dart';

import 'package:http/http.dart' as http;

class BdLivros extends ChangeNotifier {
  final List<Livro> _bdLivros = [];
  final String url = '';
  List<Livro> get bdLivros {
    return _bdLivros;
  }

  addLivros(Livro livro) {
    _bdLivros.add(
      Livro(
        titulo: livro.titulo,
        autor: livro.autor,
        genero: livro.genero,
        qtdPaginas: livro.qtdPaginas,
        metaDia: livro.metaDia,
        status: livro.status,
        pagLidas: 0,
      ),
    );

    http.post(
      Uri.parse('$url/livros.json'),
      body: jsonEncode({
        'titulo': livro.titulo,
        'autor': livro.autor,
        'genero': livro.genero,
        'pagLidas': livro.pagLidas,
        'qtdPaginas': livro.qtdPaginas,
        'metaDia': livro.metaDia,
        'status': livro.status,
      }),
    );
    notifyListeners();
  }

  Future<void> getDados() async {
    _bdLivros.clear();
    final response = await http.get(Uri.parse('$url/livros.json'));
    debugPrint(response.body);
    if (response.body == 'null') return;

    Map<String, dynamic> json = jsonDecode(response.body);
    json.forEach(
      (codLivro, livro) {
        _bdLivros.add(
          Livro(
            codigo: codLivro,
            titulo: livro['titulo'],
            autor: livro['autor'],
            genero: livro['genero'],
            pagLidas: livro['pagLidas'],
            qtdPaginas: livro['qtdPaginas'],
            metaDia: livro['metaDia'],
            status: livro['status'],
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> addPagLida(int? qtd, Livro livro) async {
    var pagL = 0;
    
    _bdLivros.forEach((element) {
      if (element.codigo == livro.codigo) {
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
      Uri.parse('$url/livros/${livro.codigo}.json'),
      body: jsonEncode(
        {'pagLidas': pagL},
      ),
    );

    notifyListeners();
  }
}
