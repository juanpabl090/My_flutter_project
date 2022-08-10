import 'package:http/http.dart' as http;

import 'package:project_1/Models/usuario.dart';
import 'package:project_1/Models/usuariosResponse.dart';
import 'package:project_1/services/auth_services.dart';

import 'package:project_1/global/enviroment.dart';

class UsuariosService {

  Future<List<Usuario>> getUsuarios() async {
    

    String? token = await AuthService.getToken();
    try {

      final uri = Uri.parse('${ Enviroment.apiUrl }/usuarios');
      final resp = await http.get(uri, 
        headers: {
          'content-Type' : 'application/json',
          'x-toke' : token.toString()
        }
      );

      final UsuariosResponse = usuariosResponseFromJson( resp.body );

      return UsuariosResponse.usuarios;

    } catch (e) {
      return [];
    }

  }

}