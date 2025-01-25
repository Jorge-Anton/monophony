import 'package:flutter/material.dart';
import 'package:monophony/models/artist_model.dart';
import 'package:monophony/widgets/horizontal_list_view.dart';
import 'package:monophony/widgets/similar_artists_tile.dart';

class QuickSimilarArtists extends StatelessWidget {
  const QuickSimilarArtists({
    super.key,
    required this.similarArtists,
  });

  final List<ArtistModel> similarArtists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 8.0),
          child: Text(
            'Artistas similares',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          height: 161,
          child: HorizontalListView(
            itemCount: similarArtists.length,
            itemBuilder: (context, index) {
              return SimilarArtistsTile(similarArtist: similarArtists[index]);
            },
          ),
        )
      ],
    );
  }
}
