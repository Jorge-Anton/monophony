import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';
import 'package:monophony/innertube/models/runs.dart';

part 'menu.g.dart';

@JsonSerializable(explicitToJson: true)
class Menu {
  @JsonKey(name: 'menuRenderer')
  final MenuRenderer? menuRenderer;

  const Menu({this.menuRenderer});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MenuRenderer {
  final List<MenuItem>? items;

  const MenuRenderer({this.items});

  factory MenuRenderer.fromJson(Map<String, dynamic> json) =>
      _$MenuRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MenuRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MenuItem {
  @JsonKey(name: 'menuNavigationItemRenderer')
  final MenuNavigationItemRenderer? menuNavigationItemRenderer;

  const MenuItem({this.menuNavigationItemRenderer});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MenuNavigationItemRenderer {
  final Runs? text;
  final NavigationEndpoint? navigationEndpoint;

  const MenuNavigationItemRenderer({
    this.text,
    this.navigationEndpoint,
  });

  factory MenuNavigationItemRenderer.fromJson(Map<String, dynamic> json) =>
      _$MenuNavigationItemRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MenuNavigationItemRendererToJson(this);
}
