import 'dart:convert';

import 'package:dona_josy/services/api/auth.dart';
import 'package:dona_josy/utils/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';

import '../models/profile.dart';

part 'home.store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  int selectedIndex = 0;

  @observable
  bool isAdmin = false;

  @observable
  bool isRoleLoaded = false;

  @observable
  List<Map<String, dynamic>> optionsMenu = [
    {'label': 'Cosméticos', 'icon': FontAwesomeIcons.bottleWater},
    {'label': 'Marmitas', 'icon': FontAwesomeIcons.utensils},
    {'label': 'Carrinho', 'icon': FontAwesomeIcons.shoppingCart},
    // {'label': 'Assistente', 'icon': FontAwesomeIcons.headset},
    {'label': 'Perfil', 'icon': FontAwesomeIcons.person},
  ];

  @action
  setIndexScreen(int value) {
    selectedIndex = value;
  }

  @action
  setAdmin(bool value) {
    isAdmin = value;
  }

  @action
  setRoleLoaded(bool value) {
    isRoleLoaded = value;
  }

  void applyRole(String role) {
    setAdmin(role.toUpperCase() == 'ADMIN');
    setRoleLoaded(true);
  }

  Future getProfile(BuildContext context) async {
    try {
      final cachedRole = await Shared().get('role');
      if (cachedRole != null) {
        applyRole(cachedRole);
        return;
      }
      final value = await AuthApi().profile();
      if (value.statusCode == 200) {
        final decodedJson = json.decode(utf8.decode(value.bodyBytes));

        final profile = Profile.fromJson(decodedJson);
        applyRole(profile.role);
        await Shared().set('role', profile.role.toUpperCase());
      } else {
        setRoleLoaded(true);
      }
    } catch (e) {
      setRoleLoaded(true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar os dados do pedido.')),
      );
    }
  }

  Future<void> loadCachedRole() async {
    final role = await Shared().get('role');
    if (role != null) setAdmin(role.toUpperCase() == 'ADMIN');
    setRoleLoaded(true);
  }
}
