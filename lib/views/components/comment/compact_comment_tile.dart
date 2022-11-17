import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comments/models/comment_model.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone/views/components/rich_text/rich_two_parts_text.dart';

class CompactCommentTile extends ConsumerWidget {
  const CompactCommentTile({
    Key? key,
    required this.commentModel,
  }) : super(key: key);

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        commentModel.fromUserId,
      ),
    );

    return userInfo.when(
      data: (userInfo) => RichTwoPartsText(
        leftPart: userInfo.displayName,
        rightPart: commentModel.comment,
      ),
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
