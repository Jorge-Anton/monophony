import 'package:flutter/foundation.dart';
import 'package:miniplayer/miniplayer.dart';

class MyMiniPlayerController {
  final ValueNotifier<double> playerExpandProgress = ValueNotifier(0);
  final ValueNotifier<double> dragDownPercentage = ValueNotifier(1);

  final MiniplayerController controller = MiniplayerController();
}
