import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monophony/innertube/models/browse_response.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/artist_model.dart';
import 'package:monophony/models/related_page_model.dart';
import 'package:monophony/models/song_model.dart';

import '../innertube.dart';

extension Related on InnerTube {
  Future<RelatedPageModel> getRelated({String? mask}) async {
    mask ??=
        'contents.sectionListRenderer.contents.musicCarouselShelfRenderer(header.musicCarouselShelfBasicHeaderRenderer(title,strapline),contents(musicResponsiveListItemRenderer(flexColumns,fixedColumns,thumbnail,navigationEndpoint,badges),musicTwoRowItemRenderer(thumbnailRenderer,title,subtitle,navigationEndpoint)))';
    final response = await client.post(
      buildUri(InnerTube.browse),
      headers: getHeaders(mask: mask),
      body: jsonEncode({...getContext(), 'browseId': 'MPTRt_tQMNz4T7xyd'}),
    );

    if (response.statusCode == 200) {
      final decodedBody = decodeResponse(response);
      final relatedResponse = BrowseResponse.fromJson(
        jsonDecode(decodedBody) as Map<String, dynamic>,
      );

      final songsSection =
          relatedResponse.contents?.sectionListRenderer?.contents?.firstWhere(
        (section) =>
            section.musicCarouselShelfRenderer?.header
                ?.musicCarouselShelfBasicHeaderRenderer?.title?.text ==
            'También te puede interesar',
      );

      final List<SongModel> songs =
          songsSection?.musicCarouselShelfRenderer?.contents
                  ?.map((item) {
                    try {
                      return SongModel.fromMusicResponsiveListItemRenderer(
                        item.musicResponsiveListItemRenderer,
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                      return null;
                    }
                  })
                  .whereType<SongModel>()
                  .toList() ??
              [];

      final artistsSection =
          relatedResponse.contents?.sectionListRenderer?.contents?.firstWhere(
        (section) =>
            section.musicCarouselShelfRenderer?.header
                ?.musicCarouselShelfBasicHeaderRenderer?.title?.text ==
            'Artistas similares',
      );

      final List<ArtistModel> artists =
          artistsSection?.musicCarouselShelfRenderer?.contents
                  ?.map((item) {
                    try {
                      return ArtistModel.fromTwoRowItemRenderer(
                        item.musicTwoRowItemRenderer,
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                      return null;
                    }
                  })
                  .whereType<ArtistModel>()
                  .toList() ??
              [];

      final albumsSection =
          relatedResponse.contents?.sectionListRenderer?.contents?.firstWhere(
        (section) =>
            section.musicCarouselShelfRenderer?.header
                ?.musicCarouselShelfBasicHeaderRenderer?.strapline?.text ==
            'MÁS DE',
      );

      final List<AlbumModel> albums =
          albumsSection?.musicCarouselShelfRenderer?.contents
                  ?.map((item) {
                    try {
                      return AlbumModel.fromMusicShelfRenderer(
                        item.musicTwoRowItemRenderer,
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                      return null;
                    }
                  })
                  .whereType<AlbumModel>()
                  .toList() ??
              [];

      return RelatedPageModel(artists: artists, albums: albums, songs: songs);
    } else {
      throw Exception('Failed to get music charts: ${response.statusCode}');
    }
  }
}
