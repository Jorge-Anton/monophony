import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/models/artist_model.dart';

class TrendingArtistTile extends StatelessWidget {
  const TrendingArtistTile({
    super.key,
    required this.artists,
    required this.index,
  });

  final List<ArtistModel> artists;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                imageUrl: artists[index].thumbnailUrl,
                height: 60,
                width: 60,
                placeholder: (context, url) {
                  return Container(
                    color: Colors.grey[600],
                    width: 60,
                    height: 60,
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    color: Colors.grey[500],
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 7.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    artists[index].name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    artists[index].subscriberCount ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
