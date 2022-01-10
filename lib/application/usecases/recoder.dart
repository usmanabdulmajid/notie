import 'package:flutter_sound/flutter_sound.dart';
import 'package:notie/domain/usecases/irecoder.dart';
import 'package:permission_handler/permission_handler.dart';

class Recoder extends IRecoder {
  //final FlutterSound flutterSound;
  final FlutterSoundRecorder flutterSoundRecorder;
  Recoder(this.flutterSoundRecorder);

  static const String filepath = 'noterecords';
  @override
  void init() async {
    await flutterSoundRecorder.openAudioSession();
  }

  @override
  Future pause() async {
    if (flutterSoundRecorder.isRecording) {
      await flutterSoundRecorder.pauseRecorder();
    }
  }

  @override
  Future record() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await flutterSoundRecorder.startRecorder(toFile: filepath);
  }

  @override
  Future<String?> stop() async {
    return await flutterSoundRecorder.stopRecorder();
  }

  @override
  Future resume() async {
    if (flutterSoundRecorder.isPaused) {
      await flutterSoundRecorder.resumeRecorder();
    }
  }

  @override
  void dispose() async {
    await flutterSoundRecorder.closeAudioSession();
  }
}
