import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/models/album_model.dart';

class AlbumTile extends StatelessWidget {
  const AlbumTile({
    super.key,
    required this.newAlbum,
  });

  final AlbumModel newAlbum;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the album details page
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: SizedBox(
          width: (MediaQuery.of(context).size.width - 67 - 40) / 2 - 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: newAlbum.thumbnailUrl,
                      placeholder: (context, url) {
                        return Container(
                          color: Colors.grey[500],
                          width: (MediaQuery.of(context).size.width - 67 - 40) /
                                  2 -
                              32,
                          height:
                              (MediaQuery.of(context).size.width - 67 - 40) /
                                      2 -
                                  32,
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
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(125),
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                newAlbum.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                newAlbum.authorsText ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
