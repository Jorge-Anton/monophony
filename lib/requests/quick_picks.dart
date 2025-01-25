import 'package:monophony/innertube/innertube.dart';
import 'package:monophony/innertube/requests/music_charts.dart';
import 'package:monophony/innertube/requests/music_explore.dart';
import 'package:monophony/innertube/requests/related.dart';
import 'package:monophony/models/quick_picks_model.dart';
import 'package:monophony/models/artist_model.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/related_page_model.dart';
import 'package:monophony/services/service_locator.dart';

Future<QuickPicksModel> getQuickPicks() async {
  final innertube = getIt<InnerTube>();

  final Future<List<ArtistModel>> trendingArtistsFuture =
      innertube.getMusicCharts();
  final Future<List<AlbumModel>> newAlbumsFuture = innertube.getMusicExplore();
  final Future<RelatedPageModel> relatedFuture = innertube.getRelated();

  final List<dynamic> results = await Future.wait<dynamic>([
    trendingArtistsFuture,
    newAlbumsFuture,
    relatedFuture,
  ]);
  final trendingArtists = results[0] as List<ArtistModel>;
  final newAlbums = results[1] as List<AlbumModel>;
  final related = results[2] as RelatedPageModel;

  return QuickPicksModel(
    trendingArtists: trendingArtists,
    similarArtists: related.artists,
    newAlbums: newAlbums,
    relatedAlbums: related.albums,
    recommendedSongs: related.songs,
  );
}
