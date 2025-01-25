import 'package:json_annotation/json_annotation.dart';
import 'music_two_row_item_renderer.dart';

part 'grid_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class GridRenderer {
  final List<Item>? items;

  const GridRenderer({this.items});

  factory GridRenderer.fromJson(Map<String, dynamic> json) =>
      _$GridRendererFromJson(json);
  Map<String, dynamic> toJson() => _$GridRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Item {
  @JsonKey(name: 'musicTwoRowItemRenderer')
  final MusicTwoRowItemRenderer? musicTwoRowItemRenderer;

  const Item({this.musicTwoRowItemRenderer});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
