import 'package:dona_josy/components/ScaffoldMessage.dart';
import 'package:dona_josy/pages/Home.dart';
import 'package:dona_josy/pages/Register.dart';
import 'package:dona_josy/services/api/auth.dart';
import 'package:dona_josy/store/home.store.dart';
import 'package:dona_josy/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:dona_josy/utils/shared/shared.dart';

part 'login.store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  Future<void> runLogin(BuildContext context) async {
    // Lógica para realizar o login
    if (formKey.currentState!.validate()) {
      ScaffoldMessage scf = ScaffoldMessage();

      NavigatorApp navigator = NavigatorApp();
      try {
        final response = await AuthApi().login(email.text, password.text);
        if (response.statusCode == 200) {
          final role = await Shared().get('role');
          if (role != null && context.mounted) {
            context.read<HomeStore>().applyRole(role);
          }
          scf.showSnackBar(
            'Login realizado com sucesso.',
            Colors.green,
            context,
          );
          navigator.nextScreen(context, HomePage(title: 'Dona Josy'));
        } else if (response.statusCode == 401) {
          scf.showSnackBar(
            'E-mail e/ou senha inválido(s).',
            Colors.redAccent,
            context,
          );
        } else {
          scf.showSnackBar(
            'Não foi possível consultar o perfil após o login.',
            Colors.redAccent,
            context,
          );
        }
      } catch (_) {
        scf.showSnackBar(
          'Não foi possível conectar ao servidor.',
          Colors.redAccent,
          context,
        );
      }
    }
  }

  @action
  void sendRegister(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }
}
