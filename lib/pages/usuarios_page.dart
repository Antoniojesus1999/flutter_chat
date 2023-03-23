import 'package:flutter/material.dart';
import 'package:flutter_chat/models/usuario.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../services/socket_service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(online: true, email: 'nerea@gmail.com', nombre: 'Nerea', uid: '1'),
    Usuario(
        online: false, email: 'javier@gmail.com', nombre: 'Javier', uid: '2'),
    Usuario(
        online: true, email: 'antonio@gmail.com', nombre: 'Antonio', uid: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario.nombre,
          style: const TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              socketService.disconect();
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            )),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[400],
                  )
                : const Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: const Color.fromARGB(255, 111, 182, 240),
        ),
        onRefresh: _cargarUsuarios,
        child: _listViewUsuarios(usuarios),
      ),
    );
  }

  ListView _listViewUsuarios(List<Usuario> usuarios) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTitle(usuarios[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTitle(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[50],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
