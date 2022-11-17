import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:instagram_clone/state/comments/models/comment_model.dart';
import 'package:instagram_clone/state/comments/models/post_comment_request.dart';
import 'package:instagram_clone/state/comments/models/post_with_comments.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/posts/models/post.dart';

final specificPostWithCommentsProvider = StreamProvider.family.autoDispose<PostWithComments, RequestForPostAndComments>(
  (ref, request) {
    final controller = StreamController<PostWithComments>();

    Post? post;
    Iterable<CommentModel>? comments;

    void notify() {
      if (post == null) {
        return;
      }

      final outputComments = (comments ?? []).applySortingFrom(
        request,
      );

      final result = PostWithComments(
        post: post!,
        comments: outputComments,
      );

      controller.sink.add(
        result,
      );
    }

    final commentsQuery = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.comments,
        )
        .where(
          FirebaseFieldName.postId,
          isEqualTo: request.postId,
        )
        .orderBy(
          FirebaseFieldName.createdAt,
          descending: true,
        );

    final limitedCommentsQuery = request.limit != null
        ? commentsQuery.limit(
            request.limit!,
          )
        : commentsQuery;

    final commentsSub = limitedCommentsQuery.snapshots().listen(
      (snapshot) {
        comments = snapshot.docs
            .where(
              (element) => !element.metadata.hasPendingWrites,
            )
            .map(
              (e) => CommentModel(
                json: e.data(),
                commentId: e.id,
              ),
            )
            .toList();

        notify();
      },
    );

    final postSub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .where(
          FieldPath.documentId,
          isEqualTo: request.postId,
        )
        .limit(
          1,
        )
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          post = null;
          comments = null;

          notify();

          return;
        } else {
          final doc = snapshot.docs.first;

          if (doc.metadata.hasPendingWrites) {
            return;
          }

          post = Post(
            postId: doc.id,
            json: doc.data(),
          );

          notify();
        }
      },
    );

    ref.onDispose(
      () {
        commentsSub.cancel();
        postSub.cancel();
        controller.close();
      },
    );

    return controller.stream;
  },
);
