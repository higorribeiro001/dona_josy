// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  late final _$profileIdAtom = Atom(
    name: '_ProfileStore.profileId',
    context: context,
  );

  @override
  String get profileId {
    _$profileIdAtom.reportRead();
    return super.profileId;
  }

  @override
  set profileId(String value) {
    _$profileIdAtom.reportWrite(value, super.profileId, () {
      super.profileId = value;
    });
  }

  late final _$getProfileAsyncAction = AsyncAction(
    '_ProfileStore.getProfile',
    context: context,
  );

  @override
  Future<dynamic> getProfile(BuildContext context) {
    return _$getProfileAsyncAction.run(() => super.getProfile(context));
  }

  late final _$loadOptionsAsyncAction = AsyncAction(
    '_ProfileStore.loadOptions',
    context: context,
  );

  @override
  Future<void> loadOptions() {
    return _$loadOptionsAsyncAction.run(() => super.loadOptions());
  }

  late final _$clearAsyncAction = AsyncAction(
    '_ProfileStore.clear',
    context: context,
  );

  @override
  Future<void> clear() {
    return _$clearAsyncAction.run(() => super.clear());
  }

  late final _$editingProfileAsyncAction = AsyncAction(
    '_ProfileStore.editingProfile',
    context: context,
  );

  @override
  Future<void> editingProfile(BuildContext context) {
    return _$editingProfileAsyncAction.run(() => super.editingProfile(context));
  }

  late final _$_ProfileStoreActionController = ActionController(
    name: '_ProfileStore',
    context: context,
  );

  @override
  dynamic setProfileId(String value) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
      name: '_ProfileStore.setProfileId',
    );
    try {
      return super.setProfileId(value);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profileId: ${profileId}
    ''';
  }
}
