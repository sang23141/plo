import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFileNotifier extends StateNotifier<File?> {
  SelectedFileNotifier() : super(null);

  //
  void setFile(File? file) {
    state = file;
  }
}

final selectedFile = StateNotifierProvider<SelectedFileNotifier, File?>(
    (ref) => SelectedFileNotifier());
