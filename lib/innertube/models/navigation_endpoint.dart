import 'package:json_annotation/json_annotation.dart';

part 'navigation_endpoint.g.dart';

@JsonSerializable(explicitToJson: true)
class NavigationEndpoint {
  final EndpointWatch? watchEndpoint;
  final EndpointWatchPlaylist? watchPlaylistEndpoint;
  final EndpointBrowse? browseEndpoint;
  final EndpointSearch? searchEndpoint;

  const NavigationEndpoint({
    this.watchEndpoint,
    this.watchPlaylistEndpoint,
    this.browseEndpoint,
    this.searchEndpoint,
  });

  Endpoint? get endpoint =>
      watchEndpoint ??
      browseEndpoint ??
      watchPlaylistEndpoint ??
      searchEndpoint;

  factory NavigationEndpoint.fromJson(Map<String, dynamic> json) =>
      _$NavigationEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$NavigationEndpointToJson(this);
}

abstract class Endpoint {}

@JsonSerializable(explicitToJson: true)
class EndpointWatch extends Endpoint {
  final String? params;
  final String? playlistId;
  final String? videoId;
  final int? index;
  final String? playlistSetVideoId;
  final WatchEndpointMusicSupportedConfigs? watchEndpointMusicSupportedConfigs;

  EndpointWatch({
    this.params,
    this.playlistId,
    this.videoId,
    this.index,
    this.playlistSetVideoId,
    this.watchEndpointMusicSupportedConfigs,
  });

  String? get type => watchEndpointMusicSupportedConfigs
      ?.watchEndpointMusicConfig?.musicVideoType;

  factory EndpointWatch.fromJson(Map<String, dynamic> json) =>
      _$EndpointWatchFromJson(json);
  Map<String, dynamic> toJson() => _$EndpointWatchToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WatchEndpointMusicSupportedConfigs {
  final WatchEndpointMusicConfig? watchEndpointMusicConfig;

  const WatchEndpointMusicSupportedConfigs({this.watchEndpointMusicConfig});

  factory WatchEndpointMusicSupportedConfigs.fromJson(
          Map<String, dynamic> json) =>
      _$WatchEndpointMusicSupportedConfigsFromJson(json);
  Map<String, dynamic> toJson() =>
      _$WatchEndpointMusicSupportedConfigsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WatchEndpointMusicConfig {
  final String? musicVideoType;

  const WatchEndpointMusicConfig({this.musicVideoType});

  factory WatchEndpointMusicConfig.fromJson(Map<String, dynamic> json) =>
      _$WatchEndpointMusicConfigFromJson(json);
  Map<String, dynamic> toJson() => _$WatchEndpointMusicConfigToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EndpointWatchPlaylist extends Endpoint {
  final String? params;
  final String? playlistId;

  EndpointWatchPlaylist({
    this.params,
    this.playlistId,
  });

  factory EndpointWatchPlaylist.fromJson(Map<String, dynamic> json) =>
      _$EndpointWatchPlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$EndpointWatchPlaylistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EndpointBrowse extends Endpoint {
  final String? params;
  final String? browseId;
  final BrowseEndpointContextSupportedConfigs?
      browseEndpointContextSupportedConfigs;

  EndpointBrowse({
    this.params,
    this.browseId,
    this.browseEndpointContextSupportedConfigs,
  });

  String? get type => browseEndpointContextSupportedConfigs
      ?.browseEndpointContextMusicConfig.pageType;

  factory EndpointBrowse.fromJson(Map<String, dynamic> json) =>
      _$EndpointBrowseFromJson(json);
  Map<String, dynamic> toJson() => _$EndpointBrowseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrowseEndpointContextSupportedConfigs {
  final BrowseEndpointContextMusicConfig browseEndpointContextMusicConfig;

  const BrowseEndpointContextSupportedConfigs(
      {required this.browseEndpointContextMusicConfig});

  factory BrowseEndpointContextSupportedConfigs.fromJson(
          Map<String, dynamic> json) =>
      _$BrowseEndpointContextSupportedConfigsFromJson(json);
  Map<String, dynamic> toJson() =>
      _$BrowseEndpointContextSupportedConfigsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrowseEndpointContextMusicConfig {
  final String pageType;

  const BrowseEndpointContextMusicConfig({required this.pageType});

  factory BrowseEndpointContextMusicConfig.fromJson(
          Map<String, dynamic> json) =>
      _$BrowseEndpointContextMusicConfigFromJson(json);
  Map<String, dynamic> toJson() =>
      _$BrowseEndpointContextMusicConfigToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EndpointSearch extends Endpoint {
  final String? params;
  final String query;

  EndpointSearch({
    this.params,
    required this.query,
  });

  factory EndpointSearch.fromJson(Map<String, dynamic> json) =>
      _$EndpointSearchFromJson(json);
  Map<String, dynamic> toJson() => _$EndpointSearchToJson(this);
}
