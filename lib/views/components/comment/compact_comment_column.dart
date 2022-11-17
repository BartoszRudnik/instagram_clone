import 'package:flutter/material.dart';
import 'package:instagram_clone/state/comments/models/comment_model.dart';
import 'package:instagram_clone/views/components/comment/compact_comment_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  const CompactCommentColumn({
    Key? key,
    required this.comments,
  }) : super(key: key);

  final Iterable<CommentModel> comments;

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          bottom: 8,
          right: 8,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => CompactCommentTile(
            commentModel: comments.elementAt(index),
          ),
          itemCount: comments.length,
        ),
      );
    }
  }
}
