import 'package:flutter/material.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/widgets/horizontal_list_view.dart';
import 'package:monophony/widgets/song_tile.dart';

class QuickSongs extends StatelessWidget {
  const QuickSongs({
    super.key,
    required this.songs,
  });

  final List<SongModel> songs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76 * 4, // 76 is the size of the song tile
      child: HorizontalListView(
          itemCount: (songs.length / 4).ceil(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                for (var i = index * 4; i < index * 4 + 4; i++)
                  if (i < songs.length)
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          (67 +
                              (index + 1 == (songs.length / 4).ceil()
                                  ? 0
                                  : 40)), // 67 is the width of the navigation buttons, and 40 is the amount of the next song that is visible
                      child: SongTile(song: songs[i]),
                    ),
              ],
            );
          }),
    );
  }
}
