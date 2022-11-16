import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comments/models/comment_payload.dart';
import 'package:instagram_clone/state/comments/typedefs/post_id.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

class SendCommentNotifier extends StateNotifier<IsLoading> {
  SendCommentNotifier() : super(false);

  set isLoading(bool newValue) => state = newValue;

  Future<bool> sendComment({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) async {
    try {
      isLoading = true;

      final payload = CommentPayload(
        userId: userId,
        postId: postId,
        comment: comment,
      );

      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.comments,
          )
          .add(
            payload,
          );

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
