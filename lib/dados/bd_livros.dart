import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:guialeitura/dados/bd.dart';
import 'package:guialeitura/models/livro.dart';
import 'package:http/http.dart' as http;

class BdLivros extends ChangeNotifier {
  final String? _token;
  final String? _uid;
   List<Livro> bdLivross;

  BdLivros(this._token, this._uid, this.bdLivross);

  List<Livro> get bdLivros => bdLivross;
  String url = Bd().urlBd;
  // Início método para Salvar/Atualizar os dados do livro.
  Future<void> salvar(Livro livro) async {
    debugPrint(livro.codigo);
    if (livro.codigo != null ) {

           bdLivros.forEach((element) {
            if(element.codigo == livro.codigo){
              
               element.codigo = livro.codigo;
               element.genero = livro.genero;
               element.metaDia = livro.metaDia;
               element.qtdPaginas = livro.qtdPaginas;
               element.uid = livro.uid;
               element.titulo = livro.titulo;
               element.status = livro.status;
               element.autor = livro.autor;
               element.pagLidas = livro.pagLidas;
               

            debugPrint('################################################################');
            debugPrint('A uqnatidade de páginas lidas é: ${element.pagLidas.toString()}');
            debugPrint('################################################################');
            }
            notifyListeners();
           });
    
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
      bdLivross.add(
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
  
    notifyListeners();

  }
  // Fim método para Salvar/Atualizar os dados do livro.

  Future<void> getDados() async {
    bdLivross=[];
    

    try {
      final response =
          await http.get(Uri.parse('$url/livros.json?auth=$_token'));

      Map<String, dynamic> json = jsonDecode(response.body);

      json.forEach(
        (codLivro, livro) {
  
       if (json[codLivro]['uid'] == _uid) { 
          bdLivross.add(
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
