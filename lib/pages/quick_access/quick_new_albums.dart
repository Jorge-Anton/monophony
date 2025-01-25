import 'package:flutter/material.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/widgets/album_tile.dart';
import 'package:monophony/widgets/horizontal_list_view.dart';

class QuickNewAlbums extends StatelessWidget {
  const QuickNewAlbums({
    super.key,
    required this.newAlbums,
  });

  final List<AlbumModel> newAlbums;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20.0),
          child: Text(
            'Nuevos álbumes',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: (MediaQuery.of(context).size.width - 43) / 2,
          child: HorizontalListView(
            itemCount: newAlbums.length,
            itemBuilder: (context, index) {
              return AlbumTile(newAlbum: newAlbums[index]);
            },
          ),
        )
      ],
    );
  }
}
