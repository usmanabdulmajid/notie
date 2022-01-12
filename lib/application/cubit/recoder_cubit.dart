import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notie/infrastructure/repositories/irecorder_repository.dart';

part 'recoder_state.dart';

class RecoderCubit extends Cubit<RecoderState> {
  final IRecorderRepository recorderRepository;
  StreamSubscription<String>? _timer;
  RecoderCubit(this.recorderRepository) : super(RecoderInitial());

  Future<void> init() async {
    await recorderRepository.initialize();
  }

  Future<void> record() async {
    await recorderRepository.record();
    _timer = recorderRepository.timer.listen((event) {
      emit(Recording(event));
    });
  }

  Future<void> pause() async {
    await recorderRepository.pause();
  }

  Future<void> resume() async {
    await recorderRepository.resume();
    _timer = recorderRepository.timer.listen((event) {
      emit(Recording(event));
    });
  }

  Future<String?> stop() async {
    final String? path = await recorderRepository.stop();
    //emit(StopRecording(path));
    return path;
  }

  Future<void> dispose() async {
    await recorderRepository.dispose();
    _timer?.cancel();
  }
}
