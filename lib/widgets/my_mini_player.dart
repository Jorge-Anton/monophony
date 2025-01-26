import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/controllers/my_mini_player_controller.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/custom_slider.dart';
import 'package:monophony/widgets/play_pause_button.dart';
import 'package:miniplayer/miniplayer.dart';

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
    return ListenableBuilder(
        listenable: songNotifier,
        builder: (context, child) {
          if (songNotifier.currentSong == null) return const SizedBox.shrink();
          return Miniplayer(
            minHeight: 84 + MediaQuery.of(context).viewPadding.bottom + 14,
            maxHeight: MediaQuery.of(context).size.height * 4 / 5,
            curve: Cubic(0.32, 0.72, 0, 1),
            duration: Durations.medium3,
            tapToCollapse: false,
            controller: myMiniPlayerController.controller,
            valueNotifier: myMiniPlayerController.playerExpandProgress,
            dragDownPercentage: myMiniPlayerController.dragDownPercentage,
            elevation: 0,
            backgroundColor: Colors.black,
            onDismissed: () {
              songNotifier.stopSong();
            },
            builder: (height, percentage) {
              return Container(
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewPadding.bottom + 14),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 4,
                        width: 24,
                        margin: const EdgeInsets.only(top: 12, bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        songNotifier.currentSong!.thumbnailUrl,
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Container(
                                        color: Colors.grey[850],
                                        width: 60,
                                        height: 60,
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        color: Colors.grey[850],
                                        width: 60,
                                        height: 60,
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                songNotifier.currentSong!.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ),
                                              ),
                                              Text(
                                                songNotifier.currentSong!
                                                        .artistsText ??
                                                    '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        PlayPauseButton(
                                          isPlaying: songNotifier.isPlaying,
                                          onPressed: () {
                                            if (songNotifier.isPlaying) {
                                              songNotifier.pauseSong();
                                            } else {
                                              songNotifier.resumeSong();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    height: 2,
                                    child: CustomSlider(
                                      activeTrackColor: Colors.white,
                                      inactiveTrackColor: Colors.grey[800],
                                      value: 0.3,
                                      onChanged: (value) {},
                                      trackShape: CustomSliderTrackShape(),
                                      thumbShape: const CustomSliderThumbShape(
                                          thumbHeight: 10, thumbRadius: 2),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
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
