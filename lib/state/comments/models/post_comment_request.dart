import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/enums/date_sorting.dart';
import 'package:instagram_clone/state/comments/typedefs/post_id.dart';

@immutable
class RequestForPostAndComments extends Equatable {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  const RequestForPostAndComments({
    required this.postId,
    this.sortByCreatedAt = true,
    this.dateSorting = DateSorting.newestOnTop,
    this.limit,
  });

  @override
  List<Object?> get props => [
        postId,
        sortByCreatedAt,
        dateSorting,
        limit,
      ];
}
