import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/posts/provider/all_posts_provider.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/post/posts_grid_view.dart';
import 'package:instagram_clone/views/constants/strings.dart';

import '../../components/animations/empty_contents_with_text_animation_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(
      allPostsProvider,
    );

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(
          allPostsProvider,
        );

        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.youHaveNoPosts,
            );
          } else {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: PostsGridView(
                posts: posts,
              ),
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
