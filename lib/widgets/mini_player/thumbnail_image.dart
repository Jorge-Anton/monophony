import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/services/service_locator.dart';

class ThumbnailImage extends StatelessWidget {
  const ThumbnailImage({
    super.key,
    required this.percentage,
    required this.thumbnailWidth,
  });

  final double percentage;
  final double thumbnailWidth;

  @override
  Widget build(BuildContext context) {
    final songNotifier = getIt<SongNotifier>();

    return Positioned(
      left: 24 + 24 * percentage,
      width: thumbnailWidth,
      top: 48 * percentage,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: songNotifier.currentSong!.bestThumbnailUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[850],
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[850],
              child: const Icon(
                Icons.error,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
