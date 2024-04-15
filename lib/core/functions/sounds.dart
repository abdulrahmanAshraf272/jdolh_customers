import 'package:audioplayers/audioplayers.dart';

abstract class Sounds {
  static Future<void> like() async {
    final player = AudioPlayer();

    // Specify the sound source as an Asset
    final source = AssetSource('sounds/facebook_likes.mp3');

    try {
      //await player.setSource(source);
      await player.play(AssetSource('sounds/facebook_likes.mp3'));
    } catch (e) {
      // handle any errors that might occur during playback
      print("Error playing audio: $e");
    }
  }
}
