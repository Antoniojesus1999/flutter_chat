import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroment.dart';
import 'package:flutter_chat/models/usuario.dart';
import 'package:http/http.dart' as http;

import '../models/login_response.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  Future login(String email, String password) async {
    autenticando = true;
    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      return true;
    } else {
      return false;
    }
  }
}
