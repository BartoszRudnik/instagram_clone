import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/enums/date_sorting.dart';
import 'package:instagram_clone/state/comments/models/post_comment_request.dart';
import 'package:instagram_clone/state/posts/models/post.dart';
import 'package:instagram_clone/state/posts/provider/can_current_user_delete_provider.dart';
import 'package:instagram_clone/state/posts/provider/specific_post_with_comments_provider.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone/views/components/comment/compact_comment_column.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/delete_dialog.dart';
import 'package:instagram_clone/views/components/like_button.dart';
import 'package:instagram_clone/views/components/post/post_date_view.dart';
import 'package:instagram_clone/views/components/post/post_display_name_and_message_view.dart';
import 'package:instagram_clone/views/components/post/post_image_or_video_view.dart';
import 'package:instagram_clone/views/components/post/post_like_count_view.dart';
import 'package:instagram_clone/views/constants/strings.dart';
import 'package:instagram_clone/views/post_comments/post_comments_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../state/posts/provider/delete_post_provider.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  const PostDetailsView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      limit: 3,
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
    );

    final postWithComments = ref.watch(
      specificPostWithCommentsProvider(
        request,
      ),
    );

    final canDelete = ref.watch(
      canCurrentUserDeletePostProvider(
        widget.post,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.postDetails,
        ),
        actions: [
          postWithComments.when(
            data: (postWithComments) => IconButton(
              onPressed: () async {
                final url = postWithComments.post.fileUrl;

                Share.share(
                  url,
                  subject: Strings.checkOutThisPost,
                );
              },
              icon: const Icon(
                Icons.share,
              ),
            ),
            error: (error, stackTrace) => const SmallErrorAnimationView(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          canDelete.when(
            data: (data) => data
                ? IconButton(
                    onPressed: () async {
                      final shouldDelete = await const DeleteDialog(
                        titleOfObjectToDelete: Strings.post,
                      )
                          .present(
                            context,
                          )
                          .then(
                            (value) => value ?? false,
                          );

                      if (shouldDelete) {
                        await ref.read(deletePostProvider.notifier).deletePost(
                              post: widget.post,
                            );

                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  )
                : const SizedBox.shrink(),
            error: (error, stackTrace) => const SmallErrorAnimationView(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      body: postWithComments.when(
        data: (data) {
          final postId = data.post.postId;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(
                  post: data.post,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (data.post.allowLikes)
                      LikeButton(
                        postId: postId,
                      ),
                    if (data.post.allowComments)
                      IconButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PostCommentsView(
                              postId: postId,
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.mode_comment_outlined,
                        ),
                      ),
                  ],
                ),
                PostDisplayNameAndMessageView(
                  post: data.post,
                ),
                PostDateView(
                  dateTime: data.post.createdAt,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white70,
                  ),
                ),
                CompactCommentColumn(
                  comments: data.comments,
                ),
                if (data.post.allowLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostLikeCountView(
                      postId: postId,
                    ),
                  ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
