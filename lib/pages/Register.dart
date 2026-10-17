import 'package:dona_josy/components/TextFormFieldWhiteApp.dart';
import 'package:dona_josy/store/register.store.dart';
import 'package:dona_josy/utils/theme.dart';
import 'package:dona_josy/utils/phone_number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<RegisterStore>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [themeData.primaryColor, themeData.colorScheme.primary],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: Image.asset('assets/images/logo_dona_josy.png'),
                  ),
                  SizedBox(height: 30.0),
                  Observer(
                    builder: (context) {
                      return Form(
                        key: store.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormFieldWhiteApp(
                              label: 'Nome*',
                              controller: store.name,
                            ),
                            TextFormFieldWhiteApp(
                              label: 'Telefone*',
                              controller: store.phone,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [PhoneNumberFormatter()],
                            ),
                            TextFormFieldWhiteApp(
                              label: 'Email*',
                              controller: store.email,
                            ),
                            TextFormFieldWhiteApp(
                              label: 'Endereço*',
                              controller: store.address,
                            ),
                            TextFormFieldWhiteApp(
                              label: 'Número*',
                              controller: store.num,
                            ),
                            TextFormFieldWhiteApp(
                              label: 'Bairro*',
                              controller: store.neighborhood,
                            ),
                            TextFormFieldWhiteApp(
                              label: 'Senha',
                              controller: store.password,
                              obscureText: true,
                              store: store,
                            ),
                            TextFormFieldWhiteApp(
                              label: 'Confirmar Senha',
                              controller: store.confPassword,
                              obscureText: true,
                              store: store,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FilledButton(
                                  onPressed: () {
                                    store.back(context);
                                  },
                                  child: const Text('VOLTAR'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (store.formKey.currentState!
                                        .validate()) {
                                      store.runRegister(context);
                                    }
                                  },
                                  child: const Text('CADASTRAR'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
