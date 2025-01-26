import 'package:flutter/material.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/custom_slider.dart';
import 'package:monophony/widgets/play_pause_button.dart';

class CollapsedContent extends StatelessWidget {
  const CollapsedContent({
    super.key,
    required this.isFullyExpanded,
    required this.percentage,
    required this.deviceWidth,
  });

  final bool isFullyExpanded;
  final double percentage;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    final songNotifier = getIt<SongNotifier>();

    return IgnorePointer(
      ignoring: isFullyExpanded,
      child: Opacity(
        opacity: (1 - percentage * 2.5).clamp(0, 1),
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                const SizedBox(width: 72),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  songNotifier.currentSong!.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  songNotifier.currentSong!.artistsText ?? '',
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
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 2,
                        child: CustomSlider(
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.grey[800],
                          value: 0.3,
                          onChanged: (value) {},
                          trackShape: CustomSliderTrackShape(),
                          thumbShape: const CustomSliderThumbShape(
                            thumbHeight: 10,
                            thumbRadius: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
