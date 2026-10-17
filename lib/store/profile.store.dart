import 'dart:convert';

import 'package:dona_josy/components/ScaffoldMessage.dart';
import 'package:dona_josy/models/profile.dart';
import 'package:dona_josy/pages/Login.dart';
import 'package:dona_josy/services/api/auth.dart';
import 'package:dona_josy/utils/shared/shared.dart';
import 'package:dona_josy/utils/phone_number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'profile.store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  @observable
  String profileId = '';
  String originalEmail = '';
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController num = TextEditingController();
  final TextEditingController neighborhood = TextEditingController();

  final api = AuthApi();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  Future getProfile(BuildContext context) async {
    try {
      final value = await api.profile();
      if (value.statusCode == 200) {
        final decodedJson = json.decode(utf8.decode(value.bodyBytes));

        final profile = Profile.fromJson(decodedJson);
        setProfileId(profile.id);
        originalEmail = profile.email;
        name.text = profile.name;
        email.text = profile.email;
        phone.text = formatPhoneNumber(profile.phone);
        address.text = profile.address;
        num.text = profile.num;
        neighborhood.text = profile.neighborhood;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar os dados do usuário.')),
      );
    }
  }

  @action
  Future<void> loadOptions() async {}

  @action
  Future<void> clear() async {
    name.text = '';
    email.text = '';
    phone.text = '';
    address.text = '';
    num.text = '';
    neighborhood.text = '';
  }

  @action
  setProfileId(String value) {
    profileId = value;
  }

  @action
  Future<void> editingProfile(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (profileId.isEmpty) {
      ScaffoldMessage().showSnackBar(
        'Não foi possível identificar o perfil. Reabra a tela e tente novamente.',
        Colors.redAccent,
        context,
      );
      return;
    }

    try {
      final response = await api.edit(
        profileId,
        name.text.trim(),
        email.text.trim(),
        phone.text.trim(),
        address.text.trim(),
        num.text.trim(),
        neighborhood.text.trim(),
      );
      if (response.statusCode == 200) {
        final emailChanged =
            email.text.trim().toLowerCase() != originalEmail.toLowerCase();
        originalEmail = email.text.trim();
        ScaffoldMessage().showSnackBar(
          emailChanged
              ? 'Perfil atualizado. Entre novamente para validar o novo email.'
              : 'Perfil atualizado com sucesso.',
          Colors.green,
          context,
        );
        if (emailChanged) {
          await Shared().clearAuthentication();
          if (context.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const Login()),
              (_) => false,
            );
          }
        }
      } else {
        ScaffoldMessage().showSnackBar(
          response.statusCode == 403
              ? 'Você não tem permissão para editar este perfil.'
              : response.statusCode == 409
              ? 'Este email já está sendo usado por outra conta.'
              : 'Não foi possível atualizar o perfil. Verifique os dados e tente novamente.',
          Colors.redAccent,
          context,
        );
      }
    } catch (_) {
      ScaffoldMessage().showSnackBar(
        'Não foi possível conectar ao servidor para atualizar o perfil.',
        Colors.redAccent,
        context,
      );
    }
  }
}
