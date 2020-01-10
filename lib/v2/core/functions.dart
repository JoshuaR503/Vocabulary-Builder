
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:meta/meta.dart';

class VocabularyBuilderFunctions {

  Future<int> playAudio({String audio, @required bool isLocal}) async {
    final AudioPlayer audioPlayer = AudioPlayer();

    return await audioPlayer
    .play(audio, isLocal: isLocal)
    .then((_) => 1)
    .catchError((error) => 0);
  }

  void deleteFile(String url) async {
    await DefaultCacheManager().removeFile(url);
  }

  int randonNumber(int max) {
    final Random random = Random();
    final int min = 1;
    final int skip = random.nextInt(max - min);

    return skip;
  }

  Future<String> saveToCache(String url) async {
    final FileInfo file =  await DefaultCacheManager().downloadFile(url);
    final String fileUrl = file.file.path;
    return fileUrl;
  }
}