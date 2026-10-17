import 'package:dona_josy/components/MessageAssistant.dart';
import 'package:dona_josy/components/MessageClient.dart';
import 'package:dona_josy/store/assistant.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class Assistant extends StatefulWidget {
  const Assistant({super.key});

  @override
  State<Assistant> createState() => _AssistantState();
}

class _AssistantState extends State<Assistant>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final store = Provider.of<AssistantStore>(context, listen: false);
      store.getMessages();
      runInAction(() => store.isLoading = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTypingIndicator() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(3, (index) {
            final phase = (_controller.value + index * 0.2) % 1.0;
            final opacity =
                0.3 +
                0.7 *
                    Curves.easeInOut.transform(
                      phase < 0.5 ? phase * 2 : (1.0 - phase) * 2,
                    );
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(opacity),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AssistantStore>(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Observer(
              builder: (context) {
                return Column(
                  children: [
                    SizedBox(height: 12.0),
                    ...store.messages.map((msg) {
                      return msg.is_assistant
                          ? MessageAssistant(
                            message: msg.message,
                            hour: msg.hour_message,
                            image: msg.image,
                          )
                          : MessageClient(
                            message: msg.message,
                            hour: msg.hour_message,
                          );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Observer(
          builder: (context) {
            return store.isLoading
                ? Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 82,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildTypingIndicator(),
                      ),
                    ),
                  ),
                )
                : SizedBox.shrink();
          },
        ),
        Form(
          key: store.formKey,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: store.message,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mensagem...',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Observer(
                builder: (context) {
                  return FloatingActionButton(
                    onPressed: () {
                      store.sendMessage();
                    },
                    child: SizedBox(
                      height: 50.0,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                    backgroundColor: Color(0xFFD29289),
                  );
                },
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
