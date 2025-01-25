import 'package:json_annotation/json_annotation.dart';
import 'thumbnail.dart';

part 'thumbnail_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class ThumbnailRenderer {
  static croppedSquareThumbnailRendererOrmusicThumbnailRenderer(map, string) {
    return map['croppedSquareThumbnailRenderer'] ??
        map['musicThumbnailRenderer'];
  }

  @JsonKey(readValue: croppedSquareThumbnailRendererOrmusicThumbnailRenderer)
  final MusicThumbnailRenderer? musicThumbnailRenderer;

  const ThumbnailRenderer({this.musicThumbnailRenderer});

  factory ThumbnailRenderer.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailRendererFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicThumbnailRenderer {
  final Thumbnail? thumbnail;

  const MusicThumbnailRenderer({this.thumbnail});

  factory MusicThumbnailRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicThumbnailRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicThumbnailRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Thumbnail {
  final List<ThumbnailItem>? thumbnails;

  const Thumbnail({this.thumbnails});

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
