import 'package:flutter/material.dart';
import 'package:monophony/models/artist_model.dart';
import 'package:monophony/widgets/horizontal_list_view.dart';
import 'package:monophony/widgets/trending_artist_tile.dart';

class QuickTrendingArtists extends StatelessWidget {
  const QuickTrendingArtists({
    super.key,
    required this.trendingArtists,
  });

  final List<ArtistModel> trendingArtists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 8.0),
          child: Text(
            'Artistas en tendencia',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 76 * 4,
          child: HorizontalListView(
            itemCount: (trendingArtists.length / 4).ceil(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  for (var i = index * 4; i < index * 4 + 4; i++)
                    if (i < trendingArtists.length)
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            (67 +
                                (index + 1 ==
                                        (trendingArtists.length / 4).ceil()
                                    ? 0
                                    : 40)),
                        child: TrendingArtistTile(
                          artists: trendingArtists,
                          index: i,
                        ),
                      ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
