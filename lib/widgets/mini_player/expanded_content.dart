import 'package:flutter/material.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/custom_slider.dart';

class ExpandedContent extends StatelessWidget {
  const ExpandedContent({
    super.key,
    required this.percentage,
    required this.thumbnailWidth,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.bottomPadding,
  });

  final double percentage;
  final double thumbnailWidth;
  final double deviceWidth;
  final double deviceHeight;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final songNotifier = getIt<SongNotifier>();

    return Positioned(
      top: 48 * percentage + thumbnailWidth + 30,
      left: 32,
      right: 32,
      height: deviceHeight * 0.8 - (deviceWidth + 2),
      child: Opacity(
        opacity: ((percentage - 0.6) / 0.4).clamp(0, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleSection(context, songNotifier),
            _buildProgressSection(),
            _buildControlButtons(),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context, SongNotifier songNotifier) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
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
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                songNotifier.currentSong!.artistsText ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[850],
            foregroundColor: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(30, 30),
            padding: EdgeInsets.zero,
          ),
          iconSize: 18,
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      children: [
        CustomSlider(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.grey[800],
          value: 0.3,
          onChanged: (value) {},
          trackShape: CustomSliderTrackShape(),
          thumbShape: const CustomSliderThumbShape(
            thumbHeight: 14,
            thumbRadius: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButton(
            Icons.favorite_border_rounded, Colors.grey[600], Colors.black),
        _buildIconButton(
            Icons.skip_previous_rounded, Colors.white, Colors.grey[850]),
        _buildIconButton(Icons.play_arrow_rounded, Colors.black, Colors.white,
            size: 38),
        _buildIconButton(
            Icons.skip_next_rounded, Colors.white, Colors.grey[850]),
        _buildIconButton(
            Icons.all_inclusive_rounded, Colors.grey[600], Colors.black),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding + 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(
              Icons.download_rounded, Colors.grey[600], Colors.black),
          IconButton(onPressed: null, icon: Icon(Icons.skip_previous_rounded)),
          IconButton(
              onPressed: null,
              icon: Icon(Icons.play_arrow_rounded),
              iconSize: 38),
          IconButton(onPressed: null, icon: Icon(Icons.skip_next_rounded)),
          _buildIconButton(Icons.list_rounded, Colors.grey[600], Colors.black),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon, Color? iconColor, Color? backgroundColor,
      {double size = 24}) {
    return IconButton(
      onPressed: () {},
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      iconSize: size,
      icon: Icon(icon, color: iconColor),
    );
  }
}
