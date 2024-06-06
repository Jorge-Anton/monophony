import 'dart:convert';

import 'package:monophony/models/song_model.dart';
import 'package:http/http.dart' as http;

Future<List<SongModel>> getQueue(String songId) async {
  List<SongModel> result = [];

  final headers = {
    'Accept': 'application/json',
    'accept-charset': 'UTF-8',
    'accept-encoding': 'gzip',
    'conection': 'Keep-Alive',
    'content-type': 'application/json',
    'host': 'music.youtube.com',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/70.0.3538.77 Chrome/70.0.3538.77 Safari/537.36',
    'x-goog-api-key': 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8',
    'x-goog-fieldmask': 'contents.singleColumnMusicWatchNextResultsRenderer.tabbedRenderer.watchNextTabbedResultsRenderer.tabs.tabRenderer.content.musicQueueRenderer.content.playlistPanelRenderer(continuations,contents(automixPreviewVideoRenderer,playlistPanelVideoRenderer(title,navigationEndpoint,longBylineText,shortBylineText,thumbnail,lengthText)))'
  };

  final body = '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"en","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"videoId":"$songId","isAudioOnly":true,"tunerSettingValue":"AUTOMIX_SETTING_NORMAL","watchEndpointMusicSupportedConfigs":{"musicVideoType":"MUSIC_VIDEO_TYPE_ATV"}}''';

  final response1 = await http.post(
    Uri.parse('https://music.youtube.com/youtubei/v1/next?prettyPrint=false'),
    body: body,
    headers: headers
  );

  if (response1.statusCode == 200) {
    final json = jsonDecode(response1.body);
    final String playlistId = json["contents"]["singleColumnMusicWatchNextResultsRenderer"]["tabbedRenderer"]["watchNextTabbedResultsRenderer"]["tabs"][0]["tabRenderer"]["content"]["musicQueueRenderer"]["content"]["playlistPanelRenderer"]["contents"][1]["automixPreviewVideoRenderer"]["content"]["automixPlaylistVideoRenderer"]["navigationEndpoint"]["watchPlaylistEndpoint"]["playlistId"];

    final body = '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"en","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"videoId":"$songId","isAudioOnly":true,"playlistId":"$playlistId","tunerSettingValue":"AUTOMIX_SETTING_NORMAL","params":"wAEB8gECeAHqBAt4SHhhYTJwZExERQ%3D%3D","watchEndpointMusicSupportedConfigs":{"musicVideoType":"MUSIC_VIDEO_TYPE_ATV"}}''';
    final response2 = await http.post(
      Uri.parse('https://music.youtube.com/youtubei/v1/next?prettyPrint=false'),
      body: body,
      headers: headers
    );

    if (response2.statusCode == 200) {
      final json = jsonDecode(response2.body);
      for (final song in json["contents"]["singleColumnMusicWatchNextResultsRenderer"]["tabbedRenderer"]["watchNextTabbedResultsRenderer"]["tabs"][0]["tabRenderer"]["content"]["musicQueueRenderer"]["content"]["playlistPanelRenderer"]["contents"]) {
        result.add(SongModel.fromNextJson(song));
      }
      return result;
    } else {
      throw Exception('Network error');
    }
  } else {
    throw Exception('Network error');
  }
}