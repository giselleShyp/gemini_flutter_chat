import 'package:flutter/material.dart';
import 'package:gemini_chat/widget/chat_text_field.dart';
import 'package:gemini_chat/widget/circle_button.dart';

class SendBar extends StatelessWidget {
  const SendBar({
    super.key,
    required this.textController,
    required this.isLoading,
    required this.onSendPressed,
  });

  final TextEditingController textController;
  final bool isLoading;
  final VoidCallback onSendPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChatTextField(
            textController: textController,
            hintText: 'start typing',
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        isLoading
            ? const CircularProgressIndicator()
            : CircleButton(
                onTap: onSendPressed,
                child: const Icon(
                  Icons.send,
                ),
              ),
      ],
    );
  }
}
