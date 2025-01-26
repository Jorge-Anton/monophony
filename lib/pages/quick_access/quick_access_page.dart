import 'package:flutter/material.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/artist_model.dart';
import 'package:monophony/models/quick_picks_model.dart';
import 'package:monophony/pages/quick_access/quick_new_albums.dart';
import 'package:monophony/pages/quick_access/quick_recommended_albums.dart';
import 'package:monophony/pages/quick_access/quick_similar_artists.dart';
import 'package:monophony/pages/quick_access/quick_songs.dart';
import 'package:monophony/pages/quick_access/quick_trending_artists.dart';
import 'package:monophony/requests/quick_picks.dart';
import 'package:monophony/services/service_locator.dart';

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
                        height: MediaQuery.of(context).viewPadding.bottom + 14,
                      ),
                      ListenableBuilder(
                        listenable: getIt<SongNotifier>(),
                        builder: (context, _) {
                          return AnimatedContainer(
                            duration: Durations.medium3,
                            curve: Cubic(0.32, 0.72, 0, 1),
                            height: getIt<SongNotifier>().currentSong != null
                                ? 84
                                : 0,
                          );
                        },
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
