import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:instagram_clone/state/comments/models/comment_model.dart';
import 'package:instagram_clone/state/comments/models/post_comment_request.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';

final postCommentsProvider = StreamProvider.family.autoDispose<Iterable<CommentModel>, RequestForPostAndComments>(
  (ref, request) {
    final streamController = StreamController<Iterable<CommentModel>>();

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.comments,
        )
        .where(
          FirebaseFieldName.postId,
          isEqualTo: request.postId,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;
        final limitedDocuments = request.limit != null
            ? documents.take(
                request.limit!,
              )
            : documents;

        final comments = limitedDocuments
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (document) => CommentModel(
                json: document.data(),
                commentId: document.id,
              ),
            );

        final result = comments.applySortingFrom(
          request,
        );

        streamController.sink.add(
          result,
        );
      },
    );

    ref.onDispose(
      () {
        streamController.close();
        sub.cancel();
      },
    );

    return streamController.stream;
  },
);
