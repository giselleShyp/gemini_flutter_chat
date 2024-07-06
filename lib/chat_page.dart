import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_chat/service/scroll_down.dart';
import 'package:gemini_chat/service/show_dialog.dart';
import 'package:gemini_chat/widget/message_widget.dart';
import 'package:gemini_chat/widget/send_bar.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final GenerativeModel model;
  late final ChatSession chatSession;

  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(
      model: "gemini-pro",
      apiKey: dotenv.env['API_KEY']!,
    );
    chatSession = model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with gemini'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                controller: scrollController,
                itemCount: chatSession.history.length,
                itemBuilder: (context, index) {
                  final Content content = chatSession.history.toList()[index];
                  final text = content.parts
                      .whereType<TextPart>()
                      .map<String>((e) => e.text)
                      .join('');

                  return MessageWidget(
                    text: text,
                    isFromUser: content.role == 'user',
                  );
                },
              ),
            ),
            SendBar(
              textController: textController,
              isLoading: isLoading,
              onSendPressed: () {
                sendChatMessage(textController.text);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendChatMessage(String message) async {
    setState(
      () {
        isLoading = true;
      },
    );

    try {
      final response = await chatSession.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null && mounted) {
        ShowDialog.showError(context, 'No response from API.');
        return;
      } else {
        setState(
          () {
            isLoading = false;
            scrollDown(scrollController);
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ShowDialog.showError(context, e.toString());
      }
      setState(
        () {
          isLoading = false;
        },
      );
    } finally {
      textController.clear();
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }
}
