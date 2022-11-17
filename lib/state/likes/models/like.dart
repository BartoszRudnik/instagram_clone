import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instagram_clone/state/comments/typedefs/post_id.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId userId,
    required DateTime dateTime,
  }) : super(
          {
            FirebaseFieldName.postId: postId,
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.date: dateTime.toIso8601String(),
          },
        );
}
