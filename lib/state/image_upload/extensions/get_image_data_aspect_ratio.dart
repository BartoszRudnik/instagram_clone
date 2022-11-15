import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_image_aspect_ratio.dart';

extension GetImageDataAspectRation on Uint8List {
  Future<double> getAspectRatio() {
    final image = Image.memory(
      this,
    );

    return image.getAspectRatio();
  }
}
