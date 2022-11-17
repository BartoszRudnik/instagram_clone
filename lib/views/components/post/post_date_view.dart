import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDateView extends StatelessWidget {
  const PostDateView({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat(
      'd MMMM, yyyy, hh:mm a',
    );

    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      child: Text(
        formatter.format(
          dateTime,
        ),
      ),
    );
  }
}
