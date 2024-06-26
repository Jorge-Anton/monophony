import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/models/album_model.dart';

class AlbumTile extends StatelessWidget {
  const AlbumTile({
    super.key,
    required this.album,
    required this.onTap
  });

  final AlbumModel album;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 14.0, top: 9.0, bottom: 9.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: album.thumbnail?.size(120) ?? '',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    ),
                  );
                }
              ),
            ),
            const SizedBox(width: 12.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  if (album.artist != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      album.artist!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ),
                  ),
                  Text(
                    album.year ?? '',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}