import 'package:flutter/material.dart';

void scrollDown(ScrollController scrollController) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCirc,
    ),
  );
}
