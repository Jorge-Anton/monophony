import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monophony/innertube/models/browse_response.dart';
import 'package:monophony/models/artist_model.dart';

import '../innertube.dart';

extension MusicCharts on InnerTube {
  Future<List<ArtistModel>> getMusicCharts({String? mask}) async {
    mask ??=
        'contents.singleColumnBrowseResultsRenderer.tabs.tabRenderer.content.sectionListRenderer.contents.musicCarouselShelfRenderer(header.musicCarouselShelfBasicHeaderRenderer.title.runs.text,contents.musicResponsiveListItemRenderer(flexColumns.musicResponsiveListItemFlexColumnRenderer.text,fixedColumns,thumbnail.musicThumbnailRenderer.thumbnail.thumbnails,navigationEndpoint.browseEndpoint.browseId))';
    final response = await client.post(
      buildUri(InnerTube.browse),
      headers: getHeaders(mask: mask),
      body: jsonEncode({...getContext(), 'browseId': 'FEmusic_charts'}),
    );

    if (response.statusCode == 200) {
      final decodedBody = decodeResponse(response);
      final chartsResponse = BrowseResponse.fromJson(
        jsonDecode(decodedBody) as Map<String, dynamic>,
      );

      final artistsSection = chartsResponse
          .contents
          ?.singleColumnBrowseResultsRenderer
          ?.tabs
          ?.firstOrNull
          ?.tabRenderer
          ?.content
          ?.sectionListRenderer
          ?.contents
          ?.firstWhere(
        (section) =>
            section.musicCarouselShelfRenderer?.header
                ?.musicCarouselShelfBasicHeaderRenderer?.title?.text ==
            'Artistas principales',
      );

      if (artistsSection == null) {
        throw Exception('Failed to find artists section');
      }

      return artistsSection.musicCarouselShelfRenderer?.contents
              ?.map((item) {
                try {
                  return ArtistModel.fromMusicCarouselShelfRenderer(
                    item.musicResponsiveListItemRenderer,
                  );
                } catch (e) {
                  debugPrint(e.toString());
                  return null;
                }
              })
              .whereType<ArtistModel>()
              .toList() ??
          [];
    } else {
      throw Exception('Failed to get music charts: ${response.statusCode}');
    }
  }
}
