import '../global/enviroment.dart';
import 'package:http/http.dart' as http;
import '../models/usuarios_response.dart';
import 'auth_service.dart';

class UsuariosService {
  Future<List<dynamic>> getUsuarios() async {
    try {
      final token = await AuthService.getToken();
      print('TOKEN -> ${token.toString()}');
      final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': token.toString()
          });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      print('error -> $e');
      return [];
    }
  }
}
