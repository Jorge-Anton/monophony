import 'package:flutter/material.dart';
import 'package:monophony/controllers/my_mini_player_controller.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/widgets/mini_player/collapsed_content.dart';
import 'package:monophony/widgets/mini_player/expanded_content.dart';
import 'package:monophony/widgets/mini_player/thumbnail_image.dart';

class MyMiniPlayer extends StatefulWidget {
  const MyMiniPlayer({super.key});

  @override
  State<MyMiniPlayer> createState() => _MyMiniPlayerState();
}

class _MyMiniPlayerState extends State<MyMiniPlayer> {
  late MyMiniPlayerController myMiniPlayerController;
  late SongNotifier songNotifier;

  @override
  void initState() {
    myMiniPlayerController = getIt<MyMiniPlayerController>();
    songNotifier = getIt<SongNotifier>();
    super.initState();
  }

  @override
  void dispose() {
    myMiniPlayerController.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final minHeight = 84 + bottomPadding + 14;
    final maxHeight = deviceHeight * 0.8;

    return ListenableBuilder(
      listenable: songNotifier,
      builder: (context, child) {
        if (songNotifier.currentSong == null) return const SizedBox.shrink();
        return Miniplayer(
          minHeight: minHeight,
          maxHeight: maxHeight,
          curve: const Cubic(0.32, 0.72, 0, 1),
          duration: Durations.medium3,
          tapToCollapse: false,
          controller: myMiniPlayerController.controller,
          valueNotifier: myMiniPlayerController.playerExpandProgress,
          dragDownPercentage: myMiniPlayerController.dragDownPercentage,
          elevation: 0,
          backgroundColor: Colors.black,
          onDismissed: songNotifier.stopSong,
          builder: (height, percentage) => MiniPlayerContent(
            height: height,
            percentage: percentage,
            minHeight: minHeight,
            maxHeight: maxHeight,
            deviceWidth: deviceWidth,
            deviceHeight: deviceHeight,
            bottomPadding: bottomPadding,
          ),
        );
      },
    );
  }
}

class MiniPlayerContent extends StatelessWidget {
  const MiniPlayerContent({
    super.key,
    required this.height,
    required this.percentage,
    required this.minHeight,
    required this.maxHeight,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.bottomPadding,
  });

  final double height;
  final double percentage;
  final double minHeight;
  final double maxHeight;
  final double deviceWidth;
  final double deviceHeight;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final isFullyExpanded = height >= maxHeight;
    final thumbnailWidth = 60 + (deviceWidth - 48 * 2 - 60) * percentage;

    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _DragHandle(),
          Expanded(
            child: Stack(
              children: [
                CollapsedContent(
                  isFullyExpanded: isFullyExpanded,
                  percentage: percentage,
                  deviceWidth: deviceWidth,
                ),
                ExpandedContent(
                  percentage: percentage,
                  thumbnailWidth: thumbnailWidth,
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  bottomPadding: bottomPadding,
                ),
                ThumbnailImage(
                  percentage: percentage,
                  thumbnailWidth: thumbnailWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Create separate widget files for these components
class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 24,
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class MyMiniPlayerPainter extends CustomPainter {
  final double radius;

  MyMiniPlayerPainter({this.radius = 25});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.arcToPoint(Offset(radius, radius),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(size.width - radius, radius);
    path.arcToPoint(Offset(size.width, 0),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(size.width, radius + 2);
    path.lineTo(0, radius + 2);
    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant MyMiniPlayerPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }
}
