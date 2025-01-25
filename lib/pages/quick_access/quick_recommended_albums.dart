import 'package:flutter/material.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/widgets/album_tile.dart';
import 'package:monophony/widgets/horizontal_list_view.dart';

class QuickRecommendedAlbums extends StatelessWidget {
  const QuickRecommendedAlbums({
    super.key,
    required this.recommendedAlbums,
  });

  final List<AlbumModel> recommendedAlbums;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 8.0),
          child: Text(
            'Álbumes recomendados',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          height: (MediaQuery.of(context).size.width - 43) / 2,
          child: HorizontalListView(
            itemCount: recommendedAlbums.length,
            itemBuilder: (context, index) {
              return AlbumTile(newAlbum: recommendedAlbums[index]);
            },
          ),
        )
      ],
    );
  }
}
