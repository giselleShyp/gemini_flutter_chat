import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.textController,
    this.style,
    this.hintStyle,
    this.prefixIcon,
    this.hintText,
    this.color,
    this.onChanged,
    this.focusNode,
    this.autofocus = true,
    this.isReplyToMessage = false,
  });

  final TextEditingController textController;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final String? hintText;
  final Color? color;
  final FocusNode? focusNode;
  final bool autofocus;
  final Function(String)? onChanged;
  final bool isReplyToMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        style: style,
        decoration: InputDecoration(
          filled: true,
          fillColor:
              color ?? Theme.of(context).colorScheme.outline.withOpacity(0.1),
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(
              topRight: isReplyToMessage
                  ? const Radius.circular(0)
                  : const Radius.circular(18),
              topLeft: isReplyToMessage
                  ? const Radius.circular(0)
                  : const Radius.circular(18),
              bottomLeft: const Radius.circular(18),
              bottomRight: const Radius.circular(18),
            ),
          ),
          hintText: hintText,
          hintStyle: hintStyle,
          prefixIcon: prefixIcon,
        ),
        autofocus: autofocus,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        minLines: 1,
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        textDirection: getTextDirection(textController.text),
      ),
    );
  }
}

// Text direction based on the input text.
TextDirection getTextDirection(String text) {
  if (text.isEmpty) {
    return TextDirection.ltr;
  }
  final firstChar = text.codeUnitAt(0);
  if ((firstChar >= 0x0600 && firstChar <= 0x06FF) || // Arabic range
      (firstChar >= 0xFB50 &&
          firstChar <= 0xFDFF) || // Arabic presentation forms range
      (firstChar >= 0xFE70 && firstChar <= 0xFEFF)) {
    // Arabic presentation forms-B range
    debugPrint('rtl');
    return TextDirection.rtl; // RTL for Arabic
  } else {
    debugPrint('ltr');
    return TextDirection.ltr; // LTR for other languages
  }
}
