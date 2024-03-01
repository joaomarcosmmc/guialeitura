import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:guialeitura/auth/exception.dart';
import 'package:guialeitura/dados/bd.dart';

import 'package:http/http.dart';

class Auth extends ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiresin;

  bool get isAuth {
    bool isValid = _expiresin?.isAfter(DateTime.now()) ?? false;
    debugPrint(' retorna:  ${_token}');
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  Future<void> _authenticate(
      String email, String senha, String composicao) async {
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

    if (body['error'] != null) {
      throw ExceptionAuth(body['error']['message']);
    } else {

      _token = body['idToken'].toString();
      _email = body['email'];
      _uid = body['localid'];
      _expiresin = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      notifyListeners();
    }
  }

  Future<void> signup(email, String senha) async {
    return _authenticate(email, senha, 'signUp');
  }

  Future<void> signin(email, senha) async {
    return _authenticate(email, senha, 'signInWithPassword');
  }
}
