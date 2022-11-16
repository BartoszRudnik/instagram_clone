import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comments/models/post_comment_request.dart';
import 'package:instagram_clone/state/comments/providers/post_comment_provider.dart';
import 'package:instagram_clone/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/comments/typedefs/post_id.dart';
import 'package:instagram_clone/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/comment/comment_tile.dart';
import 'package:instagram_clone/views/constants/strings.dart';

class PostCommentsView extends HookConsumerWidget {
  const PostCommentsView({
    super.key,
    required this.postId,
  });

  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();

    final hasText = useState(false);
    final request = useState(
      RequestForPostAndComments(
        postId: postId,
      ),
    );

    final comments = ref.watch(
      postCommentsProvider(
        request.value,
      ),
    );

    useEffect(
      () {
        commentController.addListener(
          () {
            hasText.value = commentController.text.isNotEmpty;
          },
        );
        return () {};
      },
      [commentController],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.comments,
        ),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () async {
                    final userId = ref.read(userIdProvider);

                    if (userId == null) return;

                    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
                          userId: userId,
                          postId: postId,
                          comment: commentController.text,
                        );

                    if (isSent) {
                      commentController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  }
                : null,
            icon: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentsWithTextAnimationView(
                        text: Strings.noCommentsYet,
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final comment = comments.elementAt(index);

                          return CommentTile(
                            comment: comment,
                          );
                        },
                        itemCount: comments.length,
                        padding: const EdgeInsets.all(8),
                      ),
                      onRefresh: () async {
                        ref.refresh(
                          postCommentsProvider(
                            request.value,
                          ),
                        );

                        return await Future.delayed(
                          const Duration(
                            seconds: 1,
                          ),
                        );
                      },
                    );
                  }
                },
                error: (error, stackTrace) => const ErrorAnimationView(),
                loading: () => const LoadingAnimationView(),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        Strings.writeYourCommentHere,
                      ),
                    ),
                    controller: commentController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        final userId = ref.read(userIdProvider);

                        if (userId == null) return;

                        final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
                              userId: userId,
                              postId: postId,
                              comment: commentController.text,
                            );

                        if (isSent) {
                          commentController.clear();
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
