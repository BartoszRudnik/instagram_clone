import 'dart:io';

import 'package:share_plus/share_plus.dart';

extension ToFile on Future<XFile?> {
  Future<File?> toFile() => then(
        (xFile) => xFile?.path,
      ).then(
        (filePath) => filePath != null
            ? File(
                filePath,
              )
            : null,
      );
}
