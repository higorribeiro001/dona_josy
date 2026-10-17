// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssistantStore on _AssistantStore, Store {
  late final _$formKeyAtom = Atom(
    name: '_AssistantStore.formKey',
    context: context,
  );

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  late final _$messageAtom = Atom(
    name: '_AssistantStore.message',
    context: context,
  );

  @override
  TextEditingController get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(TextEditingController value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$messagesAtom = Atom(
    name: '_AssistantStore.messages',
    context: context,
  );

  @override
  List<Assistant> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<Assistant> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AssistantStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$getMessagesAsyncAction = AsyncAction(
    '_AssistantStore.getMessages',
    context: context,
  );

  @override
  Future<dynamic> getMessages() {
    return _$getMessagesAsyncAction.run(() => super.getMessages());
  }

  late final _$sendMessageAsyncAction = AsyncAction(
    '_AssistantStore.sendMessage',
    context: context,
  );

  @override
  Future<dynamic> sendMessage() {
    return _$sendMessageAsyncAction.run(() => super.sendMessage());
  }

  @override
  String toString() {
    return '''
formKey: ${formKey},
message: ${message},
messages: ${messages},
isLoading: ${isLoading}
    ''';
  }
}
