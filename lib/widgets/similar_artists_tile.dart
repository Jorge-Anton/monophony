import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/models/artist_model.dart';

class SimilarArtistsTile extends StatelessWidget {
  const SimilarArtistsTile({
    super.key,
    required this.similarArtist,
  });

  final ArtistModel similarArtist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: similarArtist.thumbnailUrl,
                  height: 100,
                  width: 100,
                  placeholder: (context, url) {
                    return Container(
                      color: Colors.grey[500],
                      width: 100,
                      height: 100,
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
              const SizedBox(height: 8),
              Text(
                similarArtist.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                similarArtist.subscriberCount ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
