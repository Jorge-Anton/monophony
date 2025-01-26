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
              final isFullyExpanded = height >= maxHeight;
              final thumbnailWidth =
                  60 + (deviceWidth - 48 * 2 - 60) * percentage;
              return Container(
                color: Colors.black,
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
                    Expanded(
                      child: Stack(
                        children: [
                          IgnorePointer(
                            ignoring: isFullyExpanded,
                            child: Opacity(
                              opacity: (1 - percentage * 2.5).clamp(0, 1),
                              child: SizedBox(
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
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: deviceWidth - 120,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        songNotifier
                                                            .currentSong!.title,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                        ),
                                                      ),
                                                      Text(
                                                        songNotifier
                                                                .currentSong!
                                                                .artistsText ??
                                                            '',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.grey[500],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                PlayPauseButton(
                                                  isPlaying:
                                                      songNotifier.isPlaying,
                                                  onPressed: () {
                                                    if (songNotifier
                                                        .isPlaying) {
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
                                            width: deviceWidth - 120,
                                            height: 2,
                                            child: CustomSlider(
                                              activeTrackColor: Colors.white,
                                              inactiveTrackColor:
                                                  Colors.grey[800],
                                              value: 0.3,
                                              onChanged: (value) {},
                                              trackShape:
                                                  CustomSliderTrackShape(),
                                              thumbShape:
                                                  const CustomSliderThumbShape(
                                                thumbHeight: 10,
                                                thumbRadius: 2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 48 * percentage + thumbnailWidth + 30,
                            left: 32,
                            right: 32,
                            height: deviceHeight * 0.8 -
                                (48 * percentage + thumbnailWidth + 30 + 20),
                            child: Opacity(
                              opacity: ((percentage - 0.6) / 0.4).clamp(0, 1),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                                fontSize: 22,
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
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[500]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.grey[850],
                                          foregroundColor: Colors.white,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: const Size(30, 30),
                                          padding: EdgeInsets.zero,
                                        ),
                                        iconSize: 18,
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    spacing: 4,
                                    children: [
                                      SizedBox(
                                        width: deviceWidth - 32 * 2,
                                        child: CustomSlider(
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor: Colors.grey[800],
                                          value: 0.3,
                                          onChanged: (value) {},
                                          trackShape: CustomSliderTrackShape(),
                                          thumbShape:
                                              const CustomSliderThumbShape(
                                            thumbHeight: 14,
                                            thumbRadius: 3,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '2:00',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '3:28',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                        ),
                                        icon: Icon(
                                          Icons.favorite_border_rounded,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.grey[850],
                                          foregroundColor: Colors.white,
                                        ),
                                        icon: Icon(
                                          Icons.skip_previous_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                        ),
                                        iconSize: 38,
                                        icon: Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.grey[850],
                                          foregroundColor: Colors.white,
                                        ),
                                        icon: Icon(
                                          Icons.skip_next_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                        ),
                                        icon: Icon(
                                          Icons.all_inclusive_rounded,
                                          color: Colors.grey[600],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: bottomPadding + 14),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          style: IconButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            foregroundColor: Colors.white,
                                          ),
                                          icon: Icon(
                                            Icons.download_rounded,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: null,
                                          icon:
                                              Icon(Icons.skip_previous_rounded),
                                        ),
                                        IconButton(
                                          onPressed: null,
                                          iconSize: 38,
                                          icon: Icon(Icons.play_arrow_rounded),
                                        ),
                                        IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.skip_next_rounded),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          style: IconButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            foregroundColor: Colors.white,
                                          ),
                                          icon: Icon(
                                            Icons.list_rounded,
                                            color: Colors.grey[600],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 24 + 24 * percentage,
                            width: thumbnailWidth,
                            top: 48 * percentage,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: songNotifier
                                      .currentSong!.bestThumbnailUrl,
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
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
