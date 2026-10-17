import 'dart:convert';

import 'package:dona_josy/models/assistant.dart';
import 'package:dona_josy/services/api/assistant.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'assistant.store.g.dart';

class AssistantStore = _AssistantStore with _$AssistantStore;

abstract class _AssistantStore with Store {
  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  TextEditingController message = TextEditingController();

  @observable
  List<Assistant> messages = [];

  @observable
  bool isLoading = false;

  AssistantApi assistantApi = AssistantApi();

  @action
  Future getMessages() async {
    final response = await assistantApi.getChats();

    if (response.statusCode == 200) {
      final List data = json.decode(utf8.decode(response.bodyBytes));

      messages = ObservableList.of(
        data.map((item) => Assistant.fromJson(item)).toList(),
      );
    }
  }

  @action
  Future sendMessage() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading = true;
      final value = await assistantApi.setChat(message.text);
      if (value.statusCode == 201) {
        message.text = '';
        await getMessages();
      }
      isLoading = false;
    }
  }
}
