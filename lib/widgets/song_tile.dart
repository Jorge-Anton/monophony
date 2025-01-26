import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/controllers/my_mini_player_controller.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/services/service_locator.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
  });

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getIt<SongNotifier>().playSong(song);
        getIt<MyMiniPlayerController>().playerExpandProgress.value =
            90 + MediaQuery.of(context).viewPadding.bottom;
        getIt<MyMiniPlayerController>().dragDownPercentage.value = 0;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: song.thumbnailUrl,
                width: 60,
                height: 60,
                placeholder: (context, url) {
                  return Container(
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(180),
                    width: 60,
                    height: 60,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      song.artistsText ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(180),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
