// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../innertube.dart';

// extension Player on InnerTube {
//   Future<Map<String, dynamic>> getPlayer(String videoId, {String? mask}) async {
//     mask ??=
//         'playabilityStatus.status,playerConfig.audioConfig,streamingData.adaptiveFormats,videoDetails.videoId';
//     final int signatureTimestamp = 20110;
//     final Map<String, dynamic> body = {
//       "context": {
//         "client": {
//           "clientName": "IOS",
//           "clientVersion": "19.45.4",
//           "deviceMake": "Apple",
//           "deviceModel": "iPhone16,2",
//           "userAgent":
//               "com.google.ios.youtube/19.45.4 (iPhone16,2; U; CPU iOS 18_1_0 like Mac OS X;)",
//           "osName": "iPhone",
//           "osVersion": "18.1.0.22B83",
//           "hl": "en",
//           "timeZone": "UTC",
//           "utcOffsetMinutes": 0
//         }
//       },
//       "videoId": "qSNX3DwwXJA",
//       "playbackContext": {
//         "contentPlaybackContext": {
//           "html5Preference": "HTML5_PREF_WANTS",
//           "signatureTimestamp": signatureTimestamp
//         }
//       },
//       "contentCheckOk": true,
//       "racyCheckOk": true
//     };
//     try {
//       final response = await client.post(
//         buildUri(InnerTube.player),
//         headers: getHeaders(),
//         body: jsonEncode({
//           'videoId': videoId,
//           ...getContext(),
//           'playbackContext': {
//             'contentPlaybackContext': {'signatureTimestamp': signatureTimestamp}
//           }
//         }),
//       );

//       final playerResponse = jsonDecode(response.body);

//       if (playerResponse['playabilityStatus']?['status'] == 'OK') {
//         return playerResponse;
//       }

//       // Try age restriction bypass
//       final safeResponse = await client.post(
//         buildUri(InnerTube.player),
//         headers: getHeaders(),
//         body: jsonEncode({
//           'videoId': videoId,
//           ...getContext(),
//           'thirdParty': {
//             'embedUrl': 'https://www.youtube.com/watch?v=$videoId'
//           },
//           'playbackContext': {
//             'contentPlaybackContext': {
//               'signatureTimestamp': clientConfig['signatureTimestamp']
//             }
//           }
//         }),
//       );

//       final safePlayerResponse = jsonDecode(safeResponse.body);

//       if (safePlayerResponse['playabilityStatus']?['status'] != 'OK') {
//         return playerResponse;
//       }

//       // Piped fallback
//       final pipedResponse = await http.get(
//           Uri.parse('https://watchapi.whatever.social/streams/$videoId'),
//           headers: {'Content-Type': 'application/json'});

//       final audioStreams = jsonDecode(pipedResponse.body)['audioStreams'];

//       if (safePlayerResponse['streamingData']?['adaptiveFormats'] != null) {
//         safePlayerResponse['streamingData']['adaptiveFormats'] =
//             safePlayerResponse['streamingData']['adaptiveFormats']
//                 .map((format) => {
//                       ...format,
//                       'url': audioStreams.firstWhereOrNull((stream) =>
//                               stream['bitrate'] == format['bitrate'])?['url'] ??
//                           format['url']
//                     })
//                 .toList();
//       }

//       return safePlayerResponse;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
