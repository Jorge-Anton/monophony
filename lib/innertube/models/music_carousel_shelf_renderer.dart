import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/innertube/models/music_two_row_item_renderer.dart';
import 'runs.dart';
import 'button_renderer.dart';

part 'music_carousel_shelf_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicCarouselShelfRenderer {
  final Header? header;
  final List<Content>? contents;

  const MusicCarouselShelfRenderer({this.header, this.contents});

  factory MusicCarouselShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicCarouselShelfRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicCarouselShelfRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  @JsonKey(name: 'musicTwoRowItemRenderer')
  final MusicTwoRowItemRenderer? musicTwoRowItemRenderer;
  @JsonKey(name: 'musicResponsiveListItemRenderer')
  final MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;

  const Content({
    this.musicTwoRowItemRenderer,
    this.musicResponsiveListItemRenderer,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Header {
  @JsonKey(name: 'musicTwoRowItemRenderer')
  final MusicTwoRowItemRenderer? musicTwoRowItemRenderer;
  @JsonKey(name: 'musicResponsiveListItemRenderer')
  final MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;
  @JsonKey(name: 'musicCarouselShelfBasicHeaderRenderer')
  final MusicCarouselShelfBasicHeaderRenderer?
      musicCarouselShelfBasicHeaderRenderer;

  const Header({
    this.musicTwoRowItemRenderer,
    this.musicResponsiveListItemRenderer,
    this.musicCarouselShelfBasicHeaderRenderer,
  });

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicCarouselShelfBasicHeaderRenderer {
  final MoreContentButton? moreContentButton;
  final Runs? title;
  final Runs? strapline;

  const MusicCarouselShelfBasicHeaderRenderer({
    this.moreContentButton,
    this.title,
    this.strapline,
  });

  factory MusicCarouselShelfBasicHeaderRenderer.fromJson(
          Map<String, dynamic> json) =>
      _$MusicCarouselShelfBasicHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicCarouselShelfBasicHeaderRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MoreContentButton {
  final ButtonRenderer? buttonRenderer;

  const MoreContentButton({this.buttonRenderer});

  factory MoreContentButton.fromJson(Map<String, dynamic> json) =>
      _$MoreContentButtonFromJson(json);
  Map<String, dynamic> toJson() => _$MoreContentButtonToJson(this);
}
