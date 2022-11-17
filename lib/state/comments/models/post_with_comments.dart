import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/state/comments/models/comment_model.dart';
import 'package:instagram_clone/state/posts/models/post.dart';

@immutable
class PostWithComments extends Equatable {
  final Post post;
  final Iterable<CommentModel> comments;

  const PostWithComments({
    required this.post,
    required this.comments,
  });

  @override
  List<Object?> get props => [
        post,
        comments,
      ];
}
