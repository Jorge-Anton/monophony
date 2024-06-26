import 'package:flutter/material.dart';
import 'package:monophony/models/song_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:monophony/utils/print_duration.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    this.active = false,
    this.index,
    required this.onTap,
    required this.onLongPress
  });

  final SongModel song;
  final bool active;
  final int? index;
  final void Function() onTap;
  final void Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      onLongPress: () {
        onLongPress();
      },
      minVerticalPadding: 16.0,
      horizontalTitleGap: 12.0,
      contentPadding: const EdgeInsets.only(left: 16.0, right: 14.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Stack(
          children: [
            if (index != null) 
            SizedBox(
              height: 60.0,
              width: 60.0,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    fontSize: 18
                  ),
                ),
              ),
            ) else 
            CachedNetworkImage(
              imageUrl: song.artUri.toString(),
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            if (active)
            Positioned.fill(
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.4),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 32,
                ),
              )
            )
          ],
        ),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  song.artist ?? '',
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              if (song.duration != null)
              Text(
                printDuration(song.duration!),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 12
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}