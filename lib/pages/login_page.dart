import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/boton_azul.dart';
import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:flutter_chat/widgets/labels.dart';
import 'package:flutter_chat/widgets/logo.dart';
import 'package:provider/provider.dart';

import '../helpers/mostrar_alerta.dart';
import '../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(
                  titulo: 'Messenger',
                ),
                const _Form(),
                const Labels(
                    ruta: 'register',
                    titulo: '¿No tienes cuenta?',
                    subtitulo: 'Cree una ahora!'),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Correo',
            keyBoardType: TextInputType.emailAddress,
            texController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Contraseña',
            texController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
              text: 'Ingrese',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOk = await authService.login(
                          emailCtrl.text.trim(), passCtrl.text.trim());
                      if (loginOk) {
                        //TODO: Conectar a nuestro socket server

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        // ignore: use_build_context_synchronously
                        mostrarAlerta(context, 'Login incorrecto',
                            'Revise sus credenciales');
                      }
                    })
        ],
      ),
    );
  }
}
