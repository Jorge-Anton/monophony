import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/menu.dart';
import 'navigation_endpoint.dart';
import 'thumbnail_renderer.dart';
import 'runs.dart';

part 'music_two_row_item_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicTwoRowItemRenderer {
  final NavigationEndpoint? navigationEndpoint;
  final ThumbnailRenderer? thumbnailRenderer;
  final Runs? title;
  final Runs? subtitle;
  final Menu? menu;

  const MusicTwoRowItemRenderer({
    this.navigationEndpoint,
    this.thumbnailRenderer,
    this.title,
    this.subtitle,
    this.menu,
  });

  factory MusicTwoRowItemRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicTwoRowItemRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicTwoRowItemRendererToJson(this);
}
