import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  final String title;
  final String message;
  final Map<String, T> buttons;

  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
}

extension Present<T> on AlertDialogModel<T> {
  bool get isPresent => title.isNotEmpty && message.isNotEmpty;

  Future<T?> present(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: buttons.entries
            .map(
              (e) => TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(
                    e.value,
                  );
                },
                child: Text(
                  e.key,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
