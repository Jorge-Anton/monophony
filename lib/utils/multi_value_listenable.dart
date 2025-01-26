import 'package:flutter/foundation.dart';

class MultiValueListenable<T> extends ChangeNotifier {
  final List<Listenable> _listenables;

  MultiValueListenable(this._listenables) {
    for (var listenable in _listenables) {
      listenable.addListener(notifyListeners);
    }
  }

  @override
  void dispose() {
    for (var listenable in _listenables) {
      listenable.removeListener(notifyListeners);
    }
    super.dispose();
  }
}
