import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:notie/domain/usecases/irecoder.dart';
import 'package:permission_handler/permission_handler.dart';

class Recoder extends IRecoder {
  final FlutterSoundRecorder flutterSoundRecorder;
  Recoder(this.flutterSoundRecorder);
  late final StreamController<String> _timer;
  late final StreamSubscription? subscription;

  static const String _filepath = 'noterecords';
  @override
  Future<void> init() async {
    await flutterSoundRecorder.openAudioSession();
    await flutterSoundRecorder
        .setSubscriptionDuration(const Duration(milliseconds: 10));
    _timer = StreamController<String>.broadcast();
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
    await flutterSoundRecorder.startRecorder(toFile: _filepath);
    subscription = flutterSoundRecorder.onProgress?.listen((event) {
      final date =
          DateTime.fromMillisecondsSinceEpoch(event.duration.inMilliseconds);
      final time = DateFormat('mm:ss:SS', 'en_GB').format(date);
      _timer.sink.add(time);
    });
  }

  @override
  Stream<String> get timer => _timer.stream;

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
  Future<void> dispose() async {
    await flutterSoundRecorder.closeAudioSession();
    await subscription?.cancel();
    await _timer.close();
  }
}
