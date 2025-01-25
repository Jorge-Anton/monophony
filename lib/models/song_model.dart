import 'package:equatable/equatable.dart';
import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';

class SongModel extends Equatable {
  final String id;
  final String title;
  final String? artistsText;
  final String? durationText;
  final String thumbnailUrl;
  final int? likedAt;
  final int totalPlayTimeMs;

  const SongModel({
    required this.id,
    required this.title,
    this.artistsText,
    this.durationText,
    required this.thumbnailUrl,
    this.likedAt,
    this.totalPlayTimeMs = 0,
  });

  String get formattedTotalPlayTime {
    final seconds = totalPlayTimeMs ~/ 1000;
    final hours = seconds ~/ 3600;

    if (hours == 0) {
      return '${seconds ~/ 60}m';
    } else if (hours < 24) {
      return '${hours}h';
    } else {
      return '${hours ~/ 24}d';
    }
  }

  SongModel toggleLike() {
    return copyWith(
      likedAt: likedAt == null ? DateTime.now().millisecondsSinceEpoch : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        artistsText,
        durationText,
        thumbnailUrl,
        likedAt,
        totalPlayTimeMs,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artists_text': artistsText,
      'duration_text': durationText,
      'thumbnail_url': thumbnailUrl,
      'liked_at': likedAt,
      'total_play_time_ms': totalPlayTimeMs,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'],
      title: map['title'],
      artistsText: map['artists_text'],
      durationText: map['duration_text'],
      thumbnailUrl: map['thumbnail_url'],
      likedAt: map['liked_at'],
      totalPlayTimeMs: map['total_play_time_ms'] ?? 0,
    );
  }

  SongModel copyWith({
    String? id,
    String? title,
    String? artistsText,
    String? durationText,
    String? thumbnailUrl,
    int? likedAt,
    int? totalPlayTimeMs,
  }) {
    return SongModel(
      id: id ?? this.id,
      title: title ?? this.title,
      artistsText: artistsText ?? this.artistsText,
      durationText: durationText ?? this.durationText,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      likedAt: likedAt,
      totalPlayTimeMs: totalPlayTimeMs ?? this.totalPlayTimeMs,
    );
  }

  factory SongModel.fromMusicResponsiveListItemRenderer(
      MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer) {
    if (musicResponsiveListItemRenderer == null) {
      throw Exception('Failed to parse song from list item renderer');
    }

    final String? id = musicResponsiveListItemRenderer
        .flexColumns
        .firstOrNull
        ?.musicResponsiveListItemFlexColumnRenderer
        ?.text
        ?.runs
        .firstOrNull
        ?.navigationEndpoint
        ?.watchEndpoint
        ?.videoId;
    if (id == null) {
      throw Exception('Failed to parse song ID');
    }

    final String? title = musicResponsiveListItemRenderer.flexColumns
        .firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.text;
    if (title == null) {
      throw Exception('Failed to parse song title');
    }

    final String? thumbnailUrl = musicResponsiveListItemRenderer.thumbnail
        ?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull?.url;

    if (thumbnailUrl == null) {
      throw Exception('Failed to parse song thumbnail URL');
    }

    final columns = musicResponsiveListItemRenderer.flexColumns
        .map((col) => col.musicResponsiveListItemFlexColumnRenderer?.text?.text)
        .whereType<String>()
        .toList();

    return SongModel(
      id: id,
      title: title,
      artistsText: columns.length > 1 ? columns[1] : null,
      thumbnailUrl: thumbnailUrl,
    );
  }

  @override
  String toString() {
    return 'SongModel(id: $id, title: $title, artistsText: $artistsText, '
        'durationText: $durationText, thumbnailUrl: $thumbnailUrl, '
        'likedAt: $likedAt, totalPlayTimeMs: $totalPlayTimeMs)';
  }
}
