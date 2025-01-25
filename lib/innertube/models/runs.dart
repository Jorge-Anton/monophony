import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';

part 'runs.g.dart';

@JsonSerializable(explicitToJson: true)
class Runs {
  final List<Run> runs;

  const Runs({this.runs = const []});

  String get text => runs.map((run) => run.text ?? '').join('');

  List<List<Run>> splitBySeparator() {
    final List<int> indices = [];

    for (int i = 0; i < runs.length; i++) {
      if (i == 0 || i == runs.length - 1) {
        indices.add(i);
      } else if (runs[i].text == ' • ') {
        indices.add(i - 1);
        indices.add(i + 1);
      }
    }

    final List<List<Run>> result = [];
    for (int i = 0; i < indices.length; i += 2) {
      if (i + 1 < indices.length) {
        result.add(runs.sublist(indices[i], indices[i + 1] + 1));
      }
    }

    return result.isEmpty ? [runs] : result;
  }

  factory Runs.fromJson(Map<String, dynamic> json) => _$RunsFromJson(json);
  Map<String, dynamic> toJson() => _$RunsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Run {
  final String? text;
  final NavigationEndpoint? navigationEndpoint;

  const Run({
    this.text,
    this.navigationEndpoint,
  });

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);
  Map<String, dynamic> toJson() => _$RunToJson(this);
}
