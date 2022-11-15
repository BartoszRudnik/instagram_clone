import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';

@immutable
class ThumbnailRequest extends Equatable {
  final File file;
  final FileType fileType;

  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  @override
  List<Object?> get props => [
        file,
        fileType,
      ];
}
