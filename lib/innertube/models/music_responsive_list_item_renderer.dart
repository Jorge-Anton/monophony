import 'package:json_annotation/json_annotation.dart';
import 'navigation_endpoint.dart';
import 'thumbnail_renderer.dart';
import 'runs.dart';

part 'music_responsive_list_item_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicResponsiveListItemRenderer {
  final List<FlexColumn>? fixedColumns;
  final List<FlexColumn> flexColumns;
  final ThumbnailRenderer? thumbnail;
  final NavigationEndpoint? navigationEndpoint;

  const MusicResponsiveListItemRenderer({
    this.fixedColumns,
    required this.flexColumns,
    this.thumbnail,
    this.navigationEndpoint,
  });

  factory MusicResponsiveListItemRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicResponsiveListItemRendererFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveListItemRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FlexColumn {
  static musicResponsiveListItemFixedColumnRendererOrmusicResponsiveListItemFlexColumnRenderer(
      map, string) {
    return map['musicResponsiveListItemFixedColumnRenderer'] ??
        map['musicResponsiveListItemFlexColumnRenderer'];
  }

  @JsonKey(
      readValue:
          musicResponsiveListItemFixedColumnRendererOrmusicResponsiveListItemFlexColumnRenderer)
  final MusicResponsiveListItemFlexColumnRenderer?
      musicResponsiveListItemFlexColumnRenderer;

  const FlexColumn({this.musicResponsiveListItemFlexColumnRenderer});

  factory FlexColumn.fromJson(Map<String, dynamic> json) =>
      _$FlexColumnFromJson(json);
  Map<String, dynamic> toJson() => _$FlexColumnToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicResponsiveListItemFlexColumnRenderer {
  final Runs? text;

  const MusicResponsiveListItemFlexColumnRenderer({this.text});

  factory MusicResponsiveListItemFlexColumnRenderer.fromJson(
          Map<String, dynamic> json) =>
      _$MusicResponsiveListItemFlexColumnRendererFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveListItemFlexColumnRendererToJson(this);
}
