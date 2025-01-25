import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monophony/innertube/models/browse_response.dart';
import 'package:monophony/models/album_model.dart';

import '../innertube.dart';

extension MusicExplore on InnerTube {
  Future<List<AlbumModel>> getMusicExplore({String? mask}) async {
    mask ??=
        'contents.singleColumnBrowseResultsRenderer.tabs.tabRenderer.content.sectionListRenderer.contents.musicCarouselShelfRenderer(header.musicCarouselShelfBasicHeaderRenderer.title.runs.text,contents.musicTwoRowItemRenderer(thumbnailRenderer.musicThumbnailRenderer.thumbnail.thumbnails,title.runs.text,subtitle.runs.text,navigationEndpoint.browseEndpoint.browseId,menu.menuRenderer.items.menuNavigationItemRenderer(text.runs.text,navigationEndpoint.watchPlaylistEndpoint.playlistId)))';
    final response = await client.post(
      buildUri(InnerTube.browse),
      headers: getHeaders(mask: mask),
      body: jsonEncode({...getContext(), 'browseId': 'FEmusic_explore'}),
    );

    if (response.statusCode == 200) {
      final decodedBody = decodeResponse(response);
      final chartsResponse = BrowseResponse.fromJson(
        jsonDecode(decodedBody) as Map<String, dynamic>,
      );

      final albumSection = chartsResponse
          .contents
          ?.singleColumnBrowseResultsRenderer
          ?.tabs
          ?.firstOrNull
          ?.tabRenderer
          ?.content
          ?.sectionListRenderer
          ?.contents
          ?.firstWhere((section) =>
              section.musicCarouselShelfRenderer?.header
                  ?.musicCarouselShelfBasicHeaderRenderer?.title?.text ==
              'Álbumes y singles nuevos');

      if (albumSection == null) {
        throw Exception('Failed to find albums section');
      }

      return albumSection.musicCarouselShelfRenderer?.contents
              ?.map((item) {
                try {
                  return AlbumModel.fromMusicShelfRenderer(
                      item.musicTwoRowItemRenderer);
                } catch (e) {
                  debugPrint(e.toString());
                  return null;
                }
              })
              .whereType<AlbumModel>()
              .toList() ??
          [];
    } else {
      throw Exception('Failed to get music charts: ${response.statusCode}');
    }
  }
}
