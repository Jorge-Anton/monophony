import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/section_list_renderer.dart';

part 'tabs.g.dart';

@JsonSerializable(explicitToJson: true)
class Tabs {
  final List<Tab>? tabs;

  const Tabs({this.tabs});

  factory Tabs.fromJson(Map<String, dynamic> json) => _$TabsFromJson(json);
  Map<String, dynamic> toJson() => _$TabsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tab {
  @JsonKey(name: 'tabRenderer')
  final TabRenderer? tabRenderer;

  const Tab({this.tabRenderer});

  factory Tab.fromJson(Map<String, dynamic> json) => _$TabFromJson(json);
  Map<String, dynamic> toJson() => _$TabToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TabRenderer {
  final Content? content;
  final String? title;
  final String? tabIdentifier;

  const TabRenderer({
    this.content,
    this.title,
    this.tabIdentifier,
  });

  factory TabRenderer.fromJson(Map<String, dynamic> json) =>
      _$TabRendererFromJson(json);
  Map<String, dynamic> toJson() => _$TabRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  @JsonKey(name: 'sectionListRenderer')
  final SectionListRenderer? sectionListRenderer;

  const Content({this.sectionListRenderer});

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
