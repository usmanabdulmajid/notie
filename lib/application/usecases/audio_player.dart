import 'package:flutter_sound/flutter_sound.dart';
import 'package:notie/domain/usecases/iaudio_player.dart';

class AudioPlayer implements IAudioPlayer {
  final FlutterSound flutterSound;
  AudioPlayer(this.flutterSound);
  late final FlutterSoundPlayer flutterSoundPlayer;

  @override
  Future<void> init() async {
    flutterSoundPlayer = (await flutterSound.thePlayer.openAudioSession())!;
  }

  @override
  Future pause() async {
    if (flutterSoundPlayer.isPlaying) {
      flutterSoundPlayer.pausePlayer();
    }
  }

  @override
  Future play(String path) async {
    if (flutterSoundPlayer.isOpen()) {
      await flutterSoundPlayer.startPlayer(fromURI: path);
    }
  }

  @override
  Future<void> dispose() async {
    await flutterSoundPlayer.closeAudioSession();
  }
}
