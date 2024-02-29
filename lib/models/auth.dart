
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Auth extends ChangeNotifier{
  static const _authUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDgJrvso7mQad2EhVoZkv8_imlGdfWCK4A';

 Future<void> signup(String email, String senha) async{
  debugPrint('Chamando');
  final response = await post(
    Uri.parse(_authUrl),
    body: ({
      'email': email,
      'password': senha,
      'returnSecureToken': "true",
    }),
  );
  debugPrint(jsonDecode(response.body).toString());
 }  
}