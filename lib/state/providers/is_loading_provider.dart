import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_clone/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/image_upload/providers/image_uploader_provider.dart';
import 'package:instagram_clone/state/posts/provider/delete_post_provider.dart';

final isLoadingProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(
      authStateProvider,
    );
    final isUploadingimage = ref.watch(
      imageUploadProvider,
    );
    final isSendingComment = ref.watch(
      sendCommentProvider,
    );
    final isDeletingComment = ref.watch(
      deleteCommentProvider,
    );
    final isDeletingPost = ref.watch(
      deletePostProvider,
    );

    return authState.isLoading || isUploadingimage || isSendingComment || isDeletingPost || isDeletingComment;
  },
);
