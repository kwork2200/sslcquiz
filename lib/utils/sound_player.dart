import 'package:audioplayers/audioplayers.dart';

import '../data/app_data.dart';

class SoundPlayer {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static String path = "assets/sound/";

  static Future<void> playCorrect() async {
    await _playSound(path+"sound_1.mp3");
  }

  static Future<void> playWrong() async {
    await _playSound(path+"fail_sound.mp3");
  }

  static Future<void> clapSound() async {
    await _playSound(path+"sound_clap.mp3");
  }

  static Future<void> _playSound(String assetPath) async {
    bool value = (await AppData().getSound());

if(!value){
  return;
}
    try {
      await _audioPlayer.stop(); // Stop any previous sound
      await _audioPlayer.play(AssetSource(assetPath.replaceFirst('assets/', '')));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }
}
