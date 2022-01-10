import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:notie/domain/usecases/irecoder.dart';
import 'package:permission_handler/permission_handler.dart';

class Recoder extends IRecoder {
  //final FlutterSound flutterSound;
  final FlutterSoundRecorder flutterSoundRecorder;
  Recoder(this.flutterSoundRecorder);
  late final StreamController<String> timer;

  static const String _filepath = 'noterecords';
  @override
  void init() async {
    await flutterSoundRecorder.openAudioSession();
    await flutterSoundRecorder
        .setSubscriptionDuration(const Duration(milliseconds: 10));
    timer = StreamController<String>.broadcast();
  }

  @override
  Future pause() async {
    if (flutterSoundRecorder.isRecording) {
      await flutterSoundRecorder.pauseRecorder();
    }
  }

  @override
  Stream<String> record() async* {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await flutterSoundRecorder.startRecorder(toFile: _filepath);
    flutterSoundRecorder.onProgress?.listen((event) {
      final date =
          DateTime.fromMillisecondsSinceEpoch(event.duration.inMilliseconds);
      final time = DateFormat('mm:ss:SS').format(date);
      timer.sink.add(time);
    });
    yield* timer.stream;
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
    await timer.close();
  }
}
