import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/continuation.dart';
import 'package:monophony/innertube/models/grid_renderer.dart';
import 'package:monophony/innertube/models/music_carousel_shelf_renderer.dart';
import 'package:monophony/innertube/models/music_shelf_renderer.dart';
import 'package:monophony/innertube/models/runs.dart';

part 'section_list_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class SectionListRenderer {
  final List<Content>? contents;
  final List<Continuation>? continuations;

  const SectionListRenderer({
    this.contents,
    this.continuations,
  });

  factory SectionListRenderer.fromJson(Map<String, dynamic> json) =>
      _$SectionListRendererFromJson(json);
  Map<String, dynamic> toJson() => _$SectionListRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  // @JsonKey(name: 'musicImmersiveCarouselShelfRenderer')
  final MusicCarouselShelfRenderer? musicCarouselShelfRenderer;

  @JsonKey(name: 'musicPlaylistShelfRenderer')
  final MusicShelfRenderer? musicShelfRenderer;

  final GridRenderer? gridRenderer;
  final MusicDescriptionShelfRenderer? musicDescriptionShelfRenderer;

  const Content({
    this.musicCarouselShelfRenderer,
    this.musicShelfRenderer,
    this.gridRenderer,
    this.musicDescriptionShelfRenderer,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicDescriptionShelfRenderer {
  final Runs? description;

  const MusicDescriptionShelfRenderer({this.description});

  factory MusicDescriptionShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicDescriptionShelfRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicDescriptionShelfRendererToJson(this);
}
