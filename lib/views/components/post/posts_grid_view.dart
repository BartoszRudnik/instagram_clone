import 'package:flutter/material.dart';
import 'package:instagram_clone/state/posts/models/post.dart';
import 'package:instagram_clone/views/components/post/post_thumbnail_view.dart';

class PostsGridView extends StatelessWidget {
  const PostsGridView({
    super.key,
    required this.posts,
  });

  final Iterable<Post> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);

        return PostThumbnailView(
          post: post,
          onTapped: () {},
        );
      },
      padding: const EdgeInsets.all(8),
    );
  }
}
