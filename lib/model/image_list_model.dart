import 'dart:io';

import 'package:flutter/foundation.dart';

class ImageListModel extends ChangeNotifier {
  List<File> _images = [];

  List<File> get images => _images;

  void addImage(File image) {
    _images.add(image);
    notifyListeners();
  }
}
