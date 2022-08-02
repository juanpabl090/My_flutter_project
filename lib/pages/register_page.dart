// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:project_1/helpers/mostrar_alerta.dart';
import 'package:provider/provider.dart';
import 'package:project_1/services/auth_services.dart';

import 'package:project_1/widgets/custom_input.dart';
import 'package:project_1/widgets/custom_labels.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Logo(
                  titulo: 'Crea una cuenta',
                ),
                _Form(),
                Labels(
                  ruta: 'login',
                  titulo: 'Ya tienes una cuenta?',
                  subTitulo: 'Iniciar Sesión',
                ),
                Text('Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.person_outline,
            palceHolder: 'Nombre Completo',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            palceHolder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            palceHolder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BtnCustom(
            printText: 'Crear Cuenta',
            onPressed: authService.autenticando
                ? null
                : () async {
                    print(nameCtrl.text);
                    print(emailCtrl.text);
                    print(passCtrl.text);

                    final registroOk = await authService.register(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim());
                    if (registroOk == true) {
                      if (!mounted) return;
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      if (!mounted) return;
                      mostrarAlerta(context, 'Registro Incorrecto', registroOk);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
