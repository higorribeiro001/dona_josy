import 'package:dona_josy/components/TextFormFieldApp.dart';
import 'package:dona_josy/store/profile.store.dart';
import 'package:dona_josy/utils/phone_number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final store = Provider.of<ProfileStore>(context, listen: false);
      store.getProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ProfileStore>(context);

    return SingleChildScrollView(
      child: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: store.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30.0),
                        TextFormFieldApp(
                          label: 'Nome*',
                          controller: store.name,
                        ),
                        SizedBox(height: 5.0),
                        TextFormFieldApp(
                          label: 'Telefone*',
                          controller: store.phone,
                          type: TextInputType.phone,
                          inputFormatters: [PhoneNumberFormatter()],
                        ),
                        SizedBox(height: 5.0),
                        TextFormFieldApp(
                          label: 'Email*',
                          controller: store.email,
                        ),
                        SizedBox(height: 5.0),
                        TextFormFieldApp(
                          label: 'Endereço*',
                          controller: store.address,
                        ),
                        TextFormFieldApp(
                          label: 'Número*',
                          controller: store.num,
                        ),
                        SizedBox(height: 5.0),
                        TextFormFieldApp(
                          label: 'Bairro*',
                          controller: store.neighborhood,
                        ),
                        SizedBox(height: 15.0),
                        ElevatedButton(
                          onPressed: () {
                            store.editingProfile(context);
                          },
                          child: Text('Salvar'),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
