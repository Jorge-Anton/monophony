import 'package:equatable/equatable.dart';
import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/innertube/models/music_two_row_item_renderer.dart';

class ArtistModel extends Equatable {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String? subscriberCount;
  final int? bookmarkedAt;

  const ArtistModel({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    this.subscriberCount,
    this.bookmarkedAt,
  });

  @override
  List<Object?> get props =>
      [id, name, thumbnailUrl, subscriberCount, bookmarkedAt];

  @override
  String toString() {
    return 'ArtistModel(id: $id, name: $name, thumbnailUrl: $thumbnailUrl, subscriberCount: $subscriberCount, bookmarkedAt: $bookmarkedAt)';
  }

  // For database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumbnail_url': thumbnailUrl,
      'bookmarked_at': bookmarkedAt,
    };
  }

  factory ArtistModel.fromMap(Map<String, dynamic> map) {
    return ArtistModel(
      id: map['id'],
      name: map['name'],
      thumbnailUrl: map['thumbnail_url'],
      bookmarkedAt: map['bookmarked_at'],
    );
  }

  // Create a copy of the model with some fields changed
  ArtistModel copyWith({
    String? id,
    String? name,
    String? thumbnailUrl,
    int? bookmarkedAt,
  }) {
    return ArtistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
    );
  }

  factory ArtistModel.fromMusicCarouselShelfRenderer(
      MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer) {
    if (musicResponsiveListItemRenderer == null) {
      throw Exception(
          'Failed to parse artist from music carousel shelf renderer');
    }

    final String? id = musicResponsiveListItemRenderer
        .navigationEndpoint?.browseEndpoint?.browseId;

    if (id == null) {
      throw Exception('Failed to parse artist ID');
    }

    final String? name = musicResponsiveListItemRenderer.flexColumns.firstOrNull
        ?.musicResponsiveListItemFlexColumnRenderer?.text?.text;

    if (name == null) {
      throw Exception('Failed to parse artist name');
    }

    final String? thumbnailUrl = musicResponsiveListItemRenderer.thumbnail
        ?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull?.url;

    if (thumbnailUrl == null) {
      throw Exception('Failed to parse artist thumbnail URL');
    }

    final String? subscriberCount = musicResponsiveListItemRenderer.flexColumns
        .lastOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.text;

    return ArtistModel(
      id: id,
      name: name,
      thumbnailUrl: thumbnailUrl,
      subscriberCount: subscriberCount,
    );
  }

  factory ArtistModel.fromTwoRowItemRenderer(
      MusicTwoRowItemRenderer? musicTwoRowItemRenderer) {
    if (musicTwoRowItemRenderer == null) {
      throw Exception('Failed to parse artist from two row item renderer');
    }

    final String? id =
        musicTwoRowItemRenderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (id == null) {
      throw Exception('Failed to parse artist ID');
    }

    final String? name = musicTwoRowItemRenderer.title?.text;
    if (name == null) {
      throw Exception('Failed to parse artist name');
    }

    final String? thumbnailUrl = musicTwoRowItemRenderer.thumbnailRenderer
        ?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull?.url;
    if (thumbnailUrl == null) {
      throw Exception('Failed to parse artist thumbnail URL');
    }

    final String? subscriberCount = musicTwoRowItemRenderer.subtitle?.text;

    return ArtistModel(
      id: id,
      name: name,
      thumbnailUrl: thumbnailUrl,
      subscriberCount: subscriberCount,
    );
  }
}
