import 'package:flutter/cupertino.dart';
import 'package:project_1/pages/chat_page.dart';
import 'package:project_1/pages/loading_page.dart';
import 'package:project_1/pages/login_page.dart';
import 'package:project_1/pages/register_page.dart';
import 'package:project_1/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {


  'usuarios' : (_) => const UsuariosPage(),
  'chat'     : (_) => const ChatPage(),
  'login'    : (_) => const LoginPage(),
  'register' : (_) => const RegisterPage(),
  'loading'  : (_) => const LoadingPage()
  
};