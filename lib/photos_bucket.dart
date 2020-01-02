import 'dart:convert';
import 'package:flutter/services.dart';

class PhotosBucket {
  // constructor
  PhotosBucket._();

  // singleton instance
  static final PhotosBucket instance = PhotosBucket._();

  // do not initialize twice
  bool _initialized = false;

  // list of images found inside the assets directory
  final List<String> _images = [];

  // iterator to move the cursor to the next image
  Iterator<String> _iterator;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    final assetsString = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> assets = json.decode(assetsString);

    _images.addAll(assets.keys.where((key) => key.startsWith('assets/')));

    shuffle();

    _initialized = true;
  }

  void shuffle() {
    _images.shuffle();
    _iterator = _images.iterator;
  }

  String next() {
    if (_iterator.moveNext() == false) {
      shuffle();
    }

    return _iterator.current;
  }
}
