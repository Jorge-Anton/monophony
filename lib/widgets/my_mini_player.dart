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
            minHeight: 90 + MediaQuery.of(context).viewPadding.bottom,
            maxHeight: MediaQuery.of(context).size.height * 3 / 4,
            curve: Cubic(0.32, 0.72, 0, 1),
            duration: Durations.medium3,
            tapToCollapse: false,
            controller: myMiniPlayerController.controller,
            valueNotifier: myMiniPlayerController.playerExpandProgress,
            dragDownPercentage: myMiniPlayerController.dragDownPercentage,
            onDismissed: () {
              songNotifier.stopSong();
            },
            builder: (height, percentage) {
              return Container(
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 3,
                        width: 35,
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF939393),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36.0,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      songNotifier.currentSong!.thumbnailUrl,
                                  height: 60,
                                  width: 60,
                                  placeholder: (context, url) {
                                    return Container(
                                      color: Color(0xFF939393),
                                      width: 60,
                                      height: 60,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 144,
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
                                                  fontSize: 16,
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
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF939393),
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
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 144,
                                    height: 2,
                                    child: CustomSlider(
                                      activeTrackColor: Colors.white,
                                      inactiveTrackColor:
                                          const Color(0xFF6A6A6A),
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
    path.lineTo(size.width, radius);
    path.lineTo(0, radius);
    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant MyMiniPlayerPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }
}
