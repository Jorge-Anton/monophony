import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/widgets/custom_slider.dart';
import 'package:monophony/widgets/play_pause_button.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
    required this.hasCurrentSong,
    required this.songNotifier,
  });

  final bool hasCurrentSong;
  final SongNotifier songNotifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140 + MediaQuery.of(context).padding.bottom,
      child: CustomPaint(
        painter: MiniPlayerPainter(radius: 50),
        child: hasCurrentSong
            ? Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                child: Column(
                  children: [
                    Container(
                      height: 3,
                      width: 35,
                      margin: const EdgeInsets.only(top: 50 + 8),
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
                                    inactiveTrackColor: const Color(0xFF6A6A6A),
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
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class MiniPlayerPainter extends CustomPainter {
  final double radius;

  MiniPlayerPainter({this.radius = 25});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.arcToPoint(Offset(radius, radius),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(size.width - radius, radius);
    path.arcToPoint(Offset(size.width, 0),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant MiniPlayerPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }
}
