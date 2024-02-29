
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:guialeitura/utils/routes.dart';
import 'package:http/http.dart';

class Auth extends ChangeNotifier{

 Future<void> _authenticate(BuildContext context, String email, String senha, String composicao) async{

  String authUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:$composicao?key=AIzaSyDgJrvso7mQad2EhVoZkv8_imlGdfWCK4A';
  final response = await post(
    Uri.parse(authUrl),
    body: ({
      'email': email,
      'password': senha,
      'returnSecureToken': "true",
    }),
   
  ).then((value) {
   var dados = jsonDecode(value.body);
    debugPrint(dados['error'].toString());

    if(dados['error'] == null){
      Navigator.of(context).pushNamed(RoutesPage().INICIO);
    }
  });
  debugPrint(response);
 }  

  Future<void> signup(BuildContext context,String email, String senha) async{
    debugPrint('Chamando cadastro');
     await _authenticate(context,email, senha, 'signUp');
  }

 Future<void> signin(BuildContext context, email, String senha) async {
    debugPrint('Chamando login');
  await _authenticate(context, email, senha, 'signInWithPassword').then((value) => null);
}


}



