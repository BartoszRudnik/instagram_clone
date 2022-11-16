import 'package:instagram_clone/enums/date_sorting.dart';
import 'package:instagram_clone/state/comments/models/comment_model.dart';
import 'package:instagram_clone/state/comments/models/post_comment_request.dart';

extension Sorting on Iterable<CommentModel> {
  Iterable<CommentModel> applySortingFrom(RequestForPostAndComments request) {
    if (request.sortByCreatedAt) {
      final sortedDocuments = toList()
        ..sort(
          (CommentModel a, CommentModel b) {
            switch (request.dateSorting) {
              case DateSorting.newestOnTop:
                return b.createdAt.compareTo(
                  a.createdAt,
                );
              case DateSorting.oldestOnTop:
                return a.createdAt.compareTo(
                  b.createdAt,
                );
            }
          },
        );

      return sortedDocuments;
    } else {
      return this;
    }
  }
}
