import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/button_renderer.dart';
import 'package:monophony/innertube/models/runs.dart';
import 'package:monophony/innertube/models/section_list_renderer.dart';
import 'package:monophony/innertube/models/tabs.dart';
import 'package:monophony/innertube/models/thumbnail_renderer.dart';

part 'browse_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BrowseResponse {
  final Contents? contents;
  final Header? header;
  final Microformat? microformat;

  const BrowseResponse({this.contents, this.header, this.microformat});

  factory BrowseResponse.fromJson(Map<String, dynamic> json) =>
      _$BrowseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Contents {
  @JsonKey(name: 'singleColumnBrowseResultsRenderer')
  final Tabs? singleColumnBrowseResultsRenderer;
  @JsonKey(name: 'sectionListRenderer')
  final SectionListRenderer? sectionListRenderer;

  const Contents({
    this.singleColumnBrowseResultsRenderer,
    this.sectionListRenderer,
  });

  factory Contents.fromJson(Map<String, dynamic> json) =>
      _$ContentsFromJson(json);
  Map<String, dynamic> toJson() => _$ContentsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Header {
  @JsonKey(name: 'musicVisualHeaderRenderer')
  final MusicImmersiveHeaderRenderer? musicImmersiveHeaderRenderer;
  final MusicDetailHeaderRenderer? musicDetailHeaderRenderer;

  const Header({
    this.musicImmersiveHeaderRenderer,
    this.musicDetailHeaderRenderer,
  });

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicDetailHeaderRenderer {
  final Runs? title;
  final Runs? subtitle;
  final Runs? secondSubtitle;
  final ThumbnailRenderer? thumbnail;

  const MusicDetailHeaderRenderer({
    this.title,
    this.subtitle,
    this.secondSubtitle,
    this.thumbnail,
  });

  factory MusicDetailHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicDetailHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicDetailHeaderRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicImmersiveHeaderRenderer {
  final Runs? description;
  final PlayButton? playButton;
  final StartRadioButton? startRadioButton;
  final ThumbnailRenderer? thumbnail;
  final ThumbnailRenderer? foregroundThumbnail;
  final Runs? title;

  const MusicImmersiveHeaderRenderer({
    this.description,
    this.playButton,
    this.startRadioButton,
    this.thumbnail,
    this.foregroundThumbnail,
    this.title,
  });

  factory MusicImmersiveHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicImmersiveHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicImmersiveHeaderRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PlayButton {
  final ButtonRenderer? buttonRenderer;

  const PlayButton({this.buttonRenderer});

  factory PlayButton.fromJson(Map<String, dynamic> json) =>
      _$PlayButtonFromJson(json);
  Map<String, dynamic> toJson() => _$PlayButtonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StartRadioButton {
  final ButtonRenderer? buttonRenderer;

  const StartRadioButton({this.buttonRenderer});

  factory StartRadioButton.fromJson(Map<String, dynamic> json) =>
      _$StartRadioButtonFromJson(json);
  Map<String, dynamic> toJson() => _$StartRadioButtonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Microformat {
  final MicroformatDataRenderer? microformatDataRenderer;

  const Microformat({this.microformatDataRenderer});

  factory Microformat.fromJson(Map<String, dynamic> json) =>
      _$MicroformatFromJson(json);
  Map<String, dynamic> toJson() => _$MicroformatToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MicroformatDataRenderer {
  final String? urlCanonical;

  const MicroformatDataRenderer({this.urlCanonical});

  factory MicroformatDataRenderer.fromJson(Map<String, dynamic> json) =>
      _$MicroformatDataRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MicroformatDataRendererToJson(this);
}
