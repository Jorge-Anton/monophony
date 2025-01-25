import 'package:json_annotation/json_annotation.dart';

part 'continuation.g.dart';

@JsonSerializable(explicitToJson: true)
class Continuation {
  @JsonKey(name: 'nextContinuationData')
  @JsonKey(name: 'nextRadioContinuationData')
  final ContinuationData? nextContinuationData;

  const Continuation({this.nextContinuationData});

  factory Continuation.fromJson(Map<String, dynamic> json) =>
      _$ContinuationFromJson(json);
  Map<String, dynamic> toJson() => _$ContinuationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContinuationData {
  final String? continuation;

  const ContinuationData({this.continuation});

  factory ContinuationData.fromJson(Map<String, dynamic> json) =>
      _$ContinuationDataFromJson(json);
  Map<String, dynamic> toJson() => _$ContinuationDataToJson(this);
}
