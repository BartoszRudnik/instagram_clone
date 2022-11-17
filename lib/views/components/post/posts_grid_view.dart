import 'package:flutter/material.dart';
import 'package:instagram_clone/state/posts/models/post.dart';
import 'package:instagram_clone/views/components/post/post_thumbnail_view.dart';
import 'package:instagram_clone/views/post_details/post_details_view.dart';

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
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);

        return PostThumbnailView(
          post: post,
          onTapped: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailsView(
                  post: post,
                ),
              ),
            );
          },
        );
      },
      padding: const EdgeInsets.all(8),
    );
  }
}
