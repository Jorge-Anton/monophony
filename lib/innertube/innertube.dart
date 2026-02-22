import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:brotli/brotli.dart';
import 'dart:convert';

class InnerTube {
  static const String _baseUrl = 'https://music.youtube.com';
  static const String _apiKey = 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8';
  static const String _clientVersion = '1.20220606.03.00';
  static const String _userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36';
  static const String _hl = 'es';
  static const String _gl = 'ES';

  // API Endpoints
  static const String browse = '/youtubei/v1/browse';
  static const String next = '/youtubei/v1/next';
  static const String player = '/youtubei/v1/player';
  static const String queue = '/youtubei/v1/music/get_queue';
  static const String search = '/youtubei/v1/search';
  static const String searchSuggestions =
      '/youtubei/v1/music/get_search_suggestions';

  static const Map<String, String> _headers = {
    'accept': 'application/json',
    'accept-charset': 'UTF-8',
    'accept-encoding': 'gzip, deflate, br',
    'connection': 'Keep-Alive',
    'content-type': 'application/json',
    'host': 'music.youtube.com',
    'user-agent': _userAgent,
    'x-goog-api-key': _apiKey,
  };

  final http.Client _client;

  InnerTube() : _client = http.Client();

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_baseUrl$endpoint').replace(
      queryParameters: {
        'prettyPrint': 'false',
      },
    );
  }

  Map<String, String> _getHeaders({String? mask}) {
    if (mask == null) return _headers;
    return {
      ..._headers,
      'X-Goog-FieldMask': mask,
    };
  }

  Map<String, dynamic> _getContext() {
    // return {
    //   "context": {
    //     "client": {
    //       "clientName": "IOS",
    //       "clientVersion": "19.45.4",
    //       "deviceMake": "Apple",
    //       "deviceModel": "iPhone16,2",
    //       "userAgent":
    //           "com.google.ios.youtube/19.45.4 (iPhone16,2; U; CPU iOS 18_1_0 like Mac OS X;)",
    //       "osName": "iPhone",
    //       "osVersion": "18.1.0.22B83",
    //       "hl": _hl,
    //       "gl": _gl,
    //       "timeZone": "UTC",
    //       "utcOffsetMinutes": 0
    //     }
    //   },
    //   "videoId": "qSNX3DwwXJA",
    //   "playbackContext": {
    //     "contentPlaybackContext": {
    //       "html5Preference": "HTML5_PREF_WANTS",
    //       "signatureTimestamp": 20110
    //     }
    //   },
    //   "contentCheckOk": true,
    //   "racyCheckOk": true
    // };
    return {
      'context': {
        'client': {
          'clientName': 'WEB_REMIX',
          'clientVersion': _clientVersion,
          'hl': _hl,
          'gl': _gl,
          'visitorData': 'null',
          'userAgent': _userAgent,
          'referer': 'https://music.youtube.com/',
        },
      },
    };
  }

  String _decodeResponse(http.Response response) {
    final contentEncoding = response.headers['content-encoding']?.toLowerCase();
    final bytes = response.bodyBytes;

    if (contentEncoding == null) {
      return utf8.decode(bytes);
    }

    List<int> decodedBytes;
    if (contentEncoding.contains('br')) {
      decodedBytes = brotli.decode(bytes);
    } else if (contentEncoding.contains('gzip')) {
      decodedBytes = gzip.decode(bytes);
    } else if (contentEncoding.contains('deflate')) {
      decodedBytes = zlib.decode(bytes);
    } else {
      decodedBytes = bytes;
    }

    return utf8.decode(decodedBytes);
  }

  // Make decode method available to extensions
  String decodeResponse(http.Response response) => _decodeResponse(response);

  Uri buildUri(String endpoint) => _buildUri(endpoint);
  Map<String, String> getHeaders({String? mask}) => _getHeaders(mask: mask);
  Map<String, dynamic> getContext() => _getContext();
  http.Client get client => _client;

  void dispose() {
    _client.close();
  }
}
