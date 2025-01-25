import 'package:flutter/foundation.dart';
import 'package:monophony/models/song_model.dart';

class SongNotifier extends ChangeNotifier {
  SongModel? _currentSong;
  bool _isPlaying = false;

  SongModel? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  void playSong(SongModel song) {
    _currentSong = song;
    _isPlaying = true;
    notifyListeners();
  }

  void pauseSong() {
    _isPlaying = false;
    notifyListeners();
  }

  void resumeSong() {
    if (_currentSong != null) {
      _isPlaying = true;
      notifyListeners();
    }
  }

  void stopSong() {
    _currentSong = null;
    _isPlaying = false;
    notifyListeners();
  }
}
