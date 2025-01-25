import 'package:equatable/equatable.dart';
import 'artist_model.dart';
import 'album_model.dart';
import 'song_model.dart';

class QuickPicksModel extends Equatable {
  final List<ArtistModel> trendingArtists;
  final List<ArtistModel> similarArtists;
  final List<AlbumModel> newAlbums;
  final List<AlbumModel> relatedAlbums;
  final List<SongModel> recommendedSongs;

  const QuickPicksModel({
    required this.trendingArtists,
    required this.similarArtists,
    required this.newAlbums,
    required this.relatedAlbums,
    required this.recommendedSongs,
  });

  @override
  List<Object?> get props => [
        trendingArtists,
        similarArtists,
        newAlbums,
        relatedAlbums,
        recommendedSongs,
      ];

  @override
  String toString() {
    return 'QuickPicksModel('
        'trendingArtists: $trendingArtists, '
        'similarArtists: $similarArtists, '
        'newAlbums: $newAlbums, '
        'relatedAlbums: $relatedAlbums, '
        'recommendedSongs: $recommendedSongs)';
  }

  Map<String, dynamic> toMap() {
    return {
      'trending_artists': trendingArtists.map((x) => x.toMap()).toList(),
      'similar_artists': similarArtists.map((x) => x.toMap()).toList(),
      'new_releases': newAlbums.map((x) => x.toMap()).toList(),
      'related_albums': relatedAlbums.map((x) => x.toMap()).toList(),
      'recommended_songs': recommendedSongs.map((x) => x.toMap()).toList(),
    };
  }

  factory QuickPicksModel.fromMap(Map<String, dynamic> map) {
    return QuickPicksModel(
      trendingArtists: List<ArtistModel>.from(
        (map['trending_artists'] as List).map((x) => ArtistModel.fromMap(x)),
      ),
      similarArtists: List<ArtistModel>.from(
        (map['similar_artists'] as List).map((x) => ArtistModel.fromMap(x)),
      ),
      newAlbums: List<AlbumModel>.from(
        (map['new_releases'] as List).map((x) => AlbumModel.fromMap(x)),
      ),
      relatedAlbums: List<AlbumModel>.from(
        (map['related_albums'] as List).map((x) => AlbumModel.fromMap(x)),
      ),
      recommendedSongs: List<SongModel>.from(
        (map['recommended_songs'] as List).map((x) => SongModel.fromMap(x)),
      ),
    );
  }

  QuickPicksModel copyWith({
    List<ArtistModel>? trendingArtists,
    List<ArtistModel>? similarArtists,
    List<AlbumModel>? newAlbums,
    List<AlbumModel>? relatedAlbums,
    List<SongModel>? recommendedSongs,
  }) {
    return QuickPicksModel(
      trendingArtists: trendingArtists ?? this.trendingArtists,
      similarArtists: similarArtists ?? this.similarArtists,
      newAlbums: newAlbums ?? this.newAlbums,
      relatedAlbums: relatedAlbums ?? this.relatedAlbums,
      recommendedSongs: recommendedSongs ?? this.recommendedSongs,
    );
  }
}
