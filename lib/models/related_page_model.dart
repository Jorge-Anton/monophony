import 'package:equatable/equatable.dart';
import 'artist_model.dart';
import 'album_model.dart';
import 'song_model.dart';

class RelatedPageModel extends Equatable {
  final List<ArtistModel> artists;
  final List<AlbumModel> albums;
  final List<SongModel> songs;

  const RelatedPageModel({
    required this.artists,
    required this.albums,
    required this.songs,
  });

  @override
  List<Object?> get props => [artists, albums, songs];

  @override
  String toString() =>
      'RelatedPageModel(artists: $artists, albums: $albums, songs: $songs)';

  Map<String, dynamic> toMap() {
    return {
      'artists': artists.map((x) => x.toMap()).toList(),
      'albums': albums.map((x) => x.toMap()).toList(),
      'songs': songs.map((x) => x.toMap()).toList(),
    };
  }

  factory RelatedPageModel.fromMap(Map<String, dynamic> map) {
    return RelatedPageModel(
      artists: List<ArtistModel>.from(
        (map['artists'] as List).map((x) => ArtistModel.fromMap(x)),
      ),
      albums: List<AlbumModel>.from(
        (map['albums'] as List).map((x) => AlbumModel.fromMap(x)),
      ),
      songs: List<SongModel>.from(
        (map['songs'] as List).map((x) => SongModel.fromMap(x)),
      ),
    );
  }

  RelatedPageModel copyWith({
    List<ArtistModel>? artists,
    List<AlbumModel>? albums,
    List<SongModel>? songs,
  }) {
    return RelatedPageModel(
      artists: artists ?? this.artists,
      albums: albums ?? this.albums,
      songs: songs ?? this.songs,
    );
  }
}
