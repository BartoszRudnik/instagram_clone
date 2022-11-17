import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comments/typedefs/post_id.dart';
import 'package:instagram_clone/state/likes/models/like_dislike_request.dart';
import 'package:instagram_clone/state/likes/providers/has_liked_post_provider.dart';
import 'package:instagram_clone/state/likes/providers/like_dislike_post_provider.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';

class LikeButton extends ConsumerWidget {
  const LikeButton({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(
      hasLikedPostProvider(
        postId,
      ),
    );

    return hasLiked.when(
      data: (data) => IconButton(
        onPressed: () {
          final userId = ref.read(
            userIdProvider,
          );

          if (userId == null) {
            return;
          }

          final likeRequest = LikeDislikeRequest(
            postId: postId,
            userId: userId,
          );

          ref.read(
            likeDislikePostProvider(
              likeRequest,
            ),
          );
        },
        icon: Icon(
          data ? Icons.favorite : Icons.favorite_border,
        ),
      ),
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
