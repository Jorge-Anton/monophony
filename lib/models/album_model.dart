import 'package:equatable/equatable.dart';
import 'package:monophony/innertube/models/music_two_row_item_renderer.dart';

class AlbumModel extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String? authorsText;
  final String? shareUrl;
  final int? bookmarkedAt;

  const AlbumModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    this.authorsText,
    this.shareUrl,
    this.bookmarkedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        thumbnailUrl,
        authorsText,
        shareUrl,
        bookmarkedAt,
      ];

  @override
  String toString() {
    return 'AlbumModel(id: $id, title: $title, thumbnailUrl: $thumbnailUrl, authorsText: $authorsText, shareUrl: $shareUrl, bookmarkedAt: $bookmarkedAt)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail_url': thumbnailUrl,
      'authors_text': authorsText,
      'share_url': shareUrl,
      'bookmarked_at': bookmarkedAt,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      id: map['id'],
      title: map['title'],
      thumbnailUrl: map['thumbnail_url'],
      authorsText: map['authors_text'],
      shareUrl: map['share_url'],
      bookmarkedAt: map['bookmarked_at'],
    );
  }

  AlbumModel copyWith({
    String? id,
    String? title,
    String? thumbnailUrl,
    String? year,
    String? authorsText,
    String? shareUrl,
    int? bookmarkedAt,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      authorsText: authorsText ?? this.authorsText,
      shareUrl: shareUrl ?? this.shareUrl,
      bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
    );
  }

  factory AlbumModel.fromMusicShelfRenderer(
      MusicTwoRowItemRenderer? musicTwoRowItemRenderer) {
    if (musicTwoRowItemRenderer == null) {
      throw Exception('Failed to parse album from music shelf renderer');
    }

    final String? id =
        musicTwoRowItemRenderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (id == null) {
      throw Exception('Failed to parse album ID');
    }

    final String? title = musicTwoRowItemRenderer.title?.text;
    if (title == null) {
      throw Exception('Failed to parse album title');
    }

    final String? thumbnailUrl = musicTwoRowItemRenderer.thumbnailRenderer
        ?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull?.url;
    if (thumbnailUrl == null) {
      throw Exception('Failed to parse album thumbnail URL');
    }

    // Assuming year and authors are in the second flex column
    final String? subtitle = musicTwoRowItemRenderer.subtitle?.text;

    if (subtitle == null) {
      throw Exception('Failed to parse album subtitle');
    }

    String? authorsText;

    final parts = subtitle.split(' • ');
    if (parts.length > 1) {
      authorsText = parts[1];
    } else {
      authorsText = subtitle;
    }

    final String? shareId = musicTwoRowItemRenderer.menu?.menuRenderer?.items
        ?.firstWhere(
          (element) =>
              element.menuNavigationItemRenderer?.text?.text == "Aleatorio",
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint
        ?.playlistId;

    String? shareUrl;
    if (shareId != null) {
      shareUrl =
          'https://music.youtube.com/playlist?list=$shareId&feature=shared';
    }

    return AlbumModel(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
      authorsText: authorsText,
      shareUrl: shareUrl,
    );
  }
}
