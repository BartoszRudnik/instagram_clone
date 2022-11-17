import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/state/comments/typedefs/post_id.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

@immutable
class LikeDislikeRequest extends Equatable {
  final PostId postId;
  final UserId userId;

  const LikeDislikeRequest({
    required this.postId,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        postId,
        userId,
      ];
}
