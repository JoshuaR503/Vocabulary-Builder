
import 'package:audioplayers/audioplayers.dart';

class VocabularyBuilderFunctions {

  void playAudio({String audio}) async {
    final AudioPlayer audioPlayer = AudioPlayer();
    
    await audioPlayer
    .play(audio)
    .catchError((error) => print('Error: $error'));
  }
  
}