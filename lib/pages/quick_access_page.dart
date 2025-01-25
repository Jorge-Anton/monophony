import 'package:flutter/material.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/artist_model.dart';
import 'package:monophony/models/quick_picks_model.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/requests/quick_picks.dart';
import 'dart:ui';

class QuickAccessPage extends StatefulWidget {
  const QuickAccessPage({super.key});

  @override
  State<QuickAccessPage> createState() => _QuickAccessPageState();
}

class _QuickAccessPageState extends State<QuickAccessPage> {
  late Future<QuickPicksModel> _quickPicksFuture;

  @override
  void initState() {
    super.initState();
    _quickPicksFuture = getQuickPicks();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  'Acceso rápido',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              FutureBuilder<QuickPicksModel>(
                future: _quickPicksFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final quickPicks = snapshot.data!;
                  final songs = quickPicks.recommendedSongs;
                  final List<AlbumModel> newAlbums = quickPicks.newAlbums;
                  final List<AlbumModel> recommendedAlbums =
                      quickPicks.relatedAlbums;
                  final List<ArtistModel> similarArtists =
                      quickPicks.similarArtists;
                  final List<ArtistModel> trendingArtists =
                      quickPicks.trendingArtists;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (songs.isNotEmpty) QuickSongs(songs: songs),
                      if (newAlbums.isNotEmpty)
                        QuickNewAlbums(newAlbums: newAlbums),
                      if (similarArtists.isNotEmpty)
                        QuickSimilarArtists(similarArtists: similarArtists),
                      if (recommendedAlbums.isNotEmpty)
                        QuickRecommendedAlbums(
                            recommendedAlbums: recommendedAlbums),
                      if (trendingArtists.isNotEmpty)
                        QuickTrendingArtists(trendingArtists: trendingArtists),
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.bottom,
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                            artists: trendingArtists, index: i),
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
              child: Image.network(
                artists[index].thumbnailUrl,
                width: 60,
                height: 60,
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
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(180),
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
                child: Image.network(
                  similarArtist.thumbnailUrl,
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
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
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
                    child: Image.network(
                      newAlbum.thumbnailUrl,
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
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(180),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickSongs extends StatelessWidget {
  const QuickSongs({
    super.key,
    required this.songs,
  });

  final List<SongModel> songs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76 * 4, // 76 is the size of the song tile
      child: HorizontalListView(
          itemCount: (songs.length / 4).ceil(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                for (var i = index * 4; i < index * 4 + 4; i++)
                  if (i < songs.length)
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          (67 +
                              (index + 1 == (songs.length / 4).ceil()
                                  ? 0
                                  : 40)), // 67 is the width of the navigation buttons, and 40 is the amount of the next song that is visible
                      child: SongTile(song: songs[i]),
                    ),
              ],
            );
          }),
    );
  }
}

class HorizontalListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const HorizontalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // TODO: Add pagination
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

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
        // Navigate to the song details page
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
              child: Image.network(
                song.thumbnailUrl,
                width: 60,
                height: 60,
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
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
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
            )
          ],
        ),
      ),
    );
  }
}
