import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

@JsonSerializable(explicitToJson: true)
class ThumbnailItem {
  final String url;
  final int? height;
  final int? width;

  const ThumbnailItem({
    required this.url,
    this.height,
    this.width,
  });

  bool get isResizable => !url.startsWith('https://i.ytimg.com');

  String size(int size) {
    if (url.startsWith('https://lh3.googleusercontent.com')) {
      return '$url-w$size-h$size';
    } else if (url.startsWith('https://yt3.ggpht.com')) {
      return '$url-s$size';
    }
    return url;
  }

  factory ThumbnailItem.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailItemFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailItemToJson(this);
}
