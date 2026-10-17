// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$selectedIndexAtom = Atom(
    name: '_HomeStore.selectedIndex',
    context: context,
  );

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$isAdminAtom = Atom(name: '_HomeStore.isAdmin', context: context);

  @override
  bool get isAdmin {
    _$isAdminAtom.reportRead();
    return super.isAdmin;
  }

  @override
  set isAdmin(bool value) {
    _$isAdminAtom.reportWrite(value, super.isAdmin, () {
      super.isAdmin = value;
    });
  }

  late final _$isRoleLoadedAtom = Atom(
    name: '_HomeStore.isRoleLoaded',
    context: context,
  );

  @override
  bool get isRoleLoaded {
    _$isRoleLoadedAtom.reportRead();
    return super.isRoleLoaded;
  }

  @override
  set isRoleLoaded(bool value) {
    _$isRoleLoadedAtom.reportWrite(value, super.isRoleLoaded, () {
      super.isRoleLoaded = value;
    });
  }

  late final _$optionsMenuAtom = Atom(
    name: '_HomeStore.optionsMenu',
    context: context,
  );

  @override
  List<Map<String, dynamic>> get optionsMenu {
    _$optionsMenuAtom.reportRead();
    return super.optionsMenu;
  }

  @override
  set optionsMenu(List<Map<String, dynamic>> value) {
    _$optionsMenuAtom.reportWrite(value, super.optionsMenu, () {
      super.optionsMenu = value;
    });
  }

  late final _$_HomeStoreActionController = ActionController(
    name: '_HomeStore',
    context: context,
  );

  @override
  dynamic setIndexScreen(int value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
      name: '_HomeStore.setIndexScreen',
    );
    try {
      return super.setIndexScreen(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAdmin(bool value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
      name: '_HomeStore.setAdmin',
    );
    try {
      return super.setAdmin(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRoleLoaded(bool value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
      name: '_HomeStore.setRoleLoaded',
    );
    try {
      return super.setRoleLoaded(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
isAdmin: ${isAdmin},
isRoleLoaded: ${isRoleLoaded},
optionsMenu: ${optionsMenu}
    ''';
  }
}
