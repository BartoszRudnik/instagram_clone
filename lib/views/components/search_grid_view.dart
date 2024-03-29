import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/posts/provider/posts_by_search_term_provider.dart';
import 'package:instagram_clone/state/posts/typedefs/search_term.dart';
import 'package:instagram_clone/views/components/animations/data_not_found_animation_view.dart';
import 'package:instagram_clone/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/post/posts_grid_view.dart';
import 'package:instagram_clone/views/constants/strings.dart';

class SearchGridView extends ConsumerWidget {
  const SearchGridView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  final SearchTerm searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const EmptyContentsWithTextAnimationView(
        text: Strings.enterYourSearchTerm,
      );
    }

    final posts = ref.watch(
      postsBySearchTermProvider(
        searchTerm,
      ),
    );

    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const DataNotFoundAnimationView();
        } else {
          return PostsGridView(
            posts: posts,
          );
        }
      },
      error: (error, stackTrace) => const ErrorAnimationView(),
      loading: () => const LoadingAnimationView(),
    );
  }
}
