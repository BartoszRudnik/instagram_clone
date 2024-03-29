import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/animations/empty_content_animation_view.dart';

class EmptyContentsWithTextAnimationView extends StatelessWidget {
  const EmptyContentsWithTextAnimationView({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white54,
                  ),
            ),
          ),
          const EmptyContentAnimationView(),
        ],
      ),
    );
  }
}
