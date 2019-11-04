
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VocabularyBuilderFunctions {

  void playAudio({String audio}) async {
    final AudioPlayer audioPlayer = AudioPlayer();

    await audioPlayer
    .play(audio, isLocal: true)
    .catchError((error) => print('Error: $error'));
  }

  void deleteFile(String url) async {
    await DefaultCacheManager().removeFile(url);
  }

  int randonNumber(int max) {
    final Random random = Random();
    final int min = 1;
    final int skip = random.nextInt(max - min);

    print('Max $max');
    print('Random Number: $skip');

    return skip;
  }

  Future<String> saveToCache(String url) async {
    final FileInfo file =  await DefaultCacheManager().downloadFile(url);
    final String fileUrl = file.file.path;
    return fileUrl;
  }

}