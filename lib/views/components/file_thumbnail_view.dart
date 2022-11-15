import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_clone/state/image_upload/providers/thumbnail_provider.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';

class FileThumbnailView extends ConsumerWidget {
  const FileThumbnailView({
    super.key,
    required this.thumbnailRequest,
  });

  final ThumbnailRequest thumbnailRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(
      thumbnailProvider(
        thumbnailRequest,
      ),
    );

    return thumbnail.when(
      data: (imageWithAspectRatio) => AspectRatio(
        aspectRatio: imageWithAspectRatio.aspectRatio,
        child: imageWithAspectRatio.image,
      ),
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const LoadingAnimationView(),
    );
  }
}
