// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_1/pages/login_page.dart';
import 'package:project_1/pages/usuarios_page.dart';
import 'package:provider/provider.dart';
import 'package:project_1/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkloginState(context),
        builder: (BuildContext context, snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkloginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if( autenticado == true ){
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const UsuariosPage()
        ),
      );
    }else{      
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginPage()
        ),
      );
    }
  }
}
