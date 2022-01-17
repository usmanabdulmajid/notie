import 'package:flutter_sound/flutter_sound.dart';
import 'package:notie/domain/usecases/iplayer.dart';

class Player implements IPlayer {
  final FlutterSound flutterSound;
  Player(this.flutterSound);
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
      await flutterSound.thePlayer.startPlayer(fromURI: path);
      //print('zobo ${flutterSound.thePlayer.isPlaying}');
    }
  }

  @override
  Future<void> dispose() async {
    await flutterSoundPlayer.closeAudioSession();
  }
}
