import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:guialeitura/auth/exception.dart';
import 'package:guialeitura/dados/bd.dart';

import 'package:http/http.dart';

class Auth extends ChangeNotifier {
  Future<void> _authenticate( String email, String senha,
      String composicao) async {
    String authUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:$composicao?${Bd().urlKeyAuth}';
    final response = await post(
      Uri.parse(authUrl),
      body: ({
        'email': email,
        'password': senha,
        'returnSecureToken': "true",
      }),
    );

    final body = jsonDecode(response.body);
    debugPrint(body['error']['message']);
     
    if (body['error'] != null) {
      throw ExceptionAuth(body['error']['message']);
    }
  }

  Future<void> signup( email, String senha) async {
    return _authenticate( email, senha, 'signUp');
  }

  Future<void> signin(  email, senha) async {
    return _authenticate( email, senha, 'signInWithPassword');
  }
}
