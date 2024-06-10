import 'dart:convert';

import 'package:brotli/brotli.dart';
import 'package:http/http.dart' as http;
import 'package:monophony/models/artist_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_artists.g.dart';

@Riverpod(keepAlive: true)
Future<List<ArtistModel>> getArtists(GetArtistsRef ref, String query) async {
  List<ArtistModel> result = [];
  if (query == '') return result;

  final headers = {
    'Accept': 'application/json',
    'accept-charset': 'UTF-8',
    'accept-encoding': 'br',
    'conection': 'Keep-Alive',
    'content-type': 'application/json',
    'host': 'music.youtube.com',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/70.0.3538.77 Chrome/70.0.3538.77 Safari/537.36',
    'x-goog-api-key': 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8',
    'x-goog-fieldmask': 'contents.tabbedSearchResultsRenderer.tabs.tabRenderer.content.sectionListRenderer.contents.musicShelfRenderer(continuations,contents.musicResponsiveListItemRenderer(flexColumns,fixedColumns,thumbnail,navigationEndpoint))'
  };

  final body = '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"en","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"query":"$query","params":"EgWKAQIgAWoKEAkQChAFEAMQBA%3D%3D"}''';

  final res = await http.post(
    Uri.parse('https://music.youtube.com/youtubei/v1/search?prettyPrint=false'),
    body: body,
    headers: headers
  );

  final decodedBr = brotli.decodeToString(res.bodyBytes, encoding: const Utf8Codec());

  final json = jsonDecode(decodedBr);
  for (final artist in json["contents"]["tabbedSearchResultsRenderer"]["tabs"][0]["tabRenderer"]["content"]["sectionListRenderer"]["contents"][1]["musicShelfRenderer"]["contents"]) {
    result.add(ArtistModel.fromJson(artist));
  }
  return result;

  // if (res.statusCode == 200) {
  //   final json = jsonDecode(res.body);
  //   for (final artist in json["contents"]["tabbedSearchResultsRenderer"]["tabs"][0]["tabRenderer"]["content"]["sectionListRenderer"]["contents"][1]["musicShelfRenderer"]["contents"]) {
  //     result.add(ArtistModel.fromJson(artist));
  //   }
  //   return result;
  // } else {
  //   throw Exception('Network Error');
  // }

}