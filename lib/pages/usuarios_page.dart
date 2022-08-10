import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:project_1/services/socket_service.dart';
import 'package:project_1/services/usuarios_service.dart';
import 'package:project_1/Models/usuario.dart';
import 'package:project_1/services/auth_services.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarioService = UsuariosService();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // List<Usuario> usuarios = [];

  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'test1@test.com', online: true),
    Usuario(
        uid: '2', nombre: 'Fernande', email: 'test2@test.com', online: false),
    Usuario(
        uid: '3', nombre: 'Juan Pablo', email: 'test3@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final socketService = Provider.of<SocketService>(context);

    final usuario = authService.usuario;

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(usuario.nombre)),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              socketService.disconnect();
              AuthService.deleteToken();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                      ? const Icon(Icons.check_circle, color: Colors.greenAccent)
                      : const Icon(Icons.check_circle, color: Colors.red),
            ),
          ],
        ),
        body: SmartRefresher(
          onRefresh: _cargarUsuarios,
          enablePullDown: true,
          controller: _refreshController,
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: usuarios.length,
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => const Divider(),
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.greenAccent : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {

    // usuarios = await usuarioService.getUsuarios();

    // await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
