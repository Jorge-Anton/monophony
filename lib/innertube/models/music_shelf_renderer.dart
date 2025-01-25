import 'package:json_annotation/json_annotation.dart';
import 'navigation_endpoint.dart';
import 'continuation.dart';
import 'runs.dart';
import 'thumbnail.dart';
import 'music_responsive_list_item_renderer.dart';

part 'music_shelf_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicShelfRenderer {
  final NavigationEndpoint? bottomEndpoint;
  final List<Content>? contents;
  final List<Continuation>? continuations;
  final Runs? title;

  const MusicShelfRenderer({
    this.bottomEndpoint,
    this.contents,
    this.continuations,
    this.title,
  });

  factory MusicShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicShelfRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicShelfRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  @JsonKey(name: 'musicResponsiveListItemRenderer')
  final MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;

  const Content({this.musicResponsiveListItemRenderer});

  ({List<Run> mainRuns, List<List<Run>> otherRuns}) get runs {
    final firstRuns = musicResponsiveListItemRenderer?.flexColumns.firstOrNull
            ?.musicResponsiveListItemFlexColumnRenderer?.text?.runs ??
        [];

    final lastColumnRuns = musicResponsiveListItemRenderer?.flexColumns
            .lastOrNull?.musicResponsiveListItemFlexColumnRenderer?.text
            ?.splitBySeparator() ??
        [];

    return (mainRuns: firstRuns, otherRuns: lastColumnRuns);
  }

  ThumbnailItem? get thumbnail => musicResponsiveListItemRenderer
      ?.thumbnail?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
