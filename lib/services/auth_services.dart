import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_1/Models/login_response.dart';
import 'package:project_1/Models/usuario.dart';
import 'package:project_1/global/enviroment.dart';

class AuthService with ChangeNotifier{  

  late Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => _autenticando;
  set autenticando( bool valor ){
     _autenticando = valor;
     notifyListeners();
  }

  Future<bool> login ( String email, String password) async {

    autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    final uri = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(resp.body);

    autenticando = false;

    if( resp.statusCode == 200){
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;

      //TODO: GUARDAR TOKEN EN LUGAR SEGURO:
      
      return true;
    }else{
      return false;
    }
  }
}