import 'package:dona_josy/components/ScaffoldMessage.dart';
import 'package:dona_josy/pages/Home.dart';
import 'package:dona_josy/pages/Login.dart';
import 'package:dona_josy/services/api/auth.dart';
import 'package:dona_josy/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'register.store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController num = TextEditingController();
  final TextEditingController neighborhood = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  void back(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
  }

  @action
  void clear() {
    name.text = '';
    email.text = '';
    phone.text = '';
    address.text = '';
    num.text = '';
    neighborhood.text = '';
    password.text = '';
    confPassword.text = '';
  }

  @action
  void runRegister(BuildContext context) {
    // Lógica para realizar o cadastro
    if (formKey.currentState!.validate()) {
      ScaffoldMessage scf = ScaffoldMessage();

      NavigatorApp navigator = NavigatorApp();
      AuthApi()
          .register(
            name.text,
            email.text,
            phone.text,
            address.text,
            num.text,
            neighborhood.text,
            password.text,
          )
          .then(
            (value) => {
              if (value.statusCode == 201)
                {
                  scf.showSnackBar(
                    'Cadastro realizado com sucesso.',
                    Colors.green,
                    context,
                  ),
                  clear(),
                  navigator.nextScreen(context, const Login()),
                }
              else
                {
                  scf.showSnackBar(
                    'Erro inesperado, tente novamente mais tarde.',
                    Colors.redAccent,
                    context,
                  ),
                },
            },
          );
    }
  }
}
