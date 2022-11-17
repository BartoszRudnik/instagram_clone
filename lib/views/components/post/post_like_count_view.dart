import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comments/typedefs/post_id.dart';
import 'package:instagram_clone/state/likes/providers/post_likes_count_provider.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone/views/components/constants/strings.dart';

class PostLikeCountView extends ConsumerWidget {
  const PostLikeCountView({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(
      postLikeCountProvider(
        postId,
      ),
    );

    return likesCount.when(
      data: (data) {
        final personOrPeople = data == 1 ? Strings.person : Strings.people;
        final likesText = '$data $personOrPeople liked this';

        return Text(
          likesText,
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const LoadingAnimationView(),
    );
  }
}
