import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notie/infrastructure/repositories/irecorder_repository.dart';

part 'recoder_state.dart';

class RecoderCubit extends Cubit<RecoderState> {
  final IRecorderRepository recorderRepository;
  RecoderCubit(this.recorderRepository) : super(RecoderInitial());

  Future<void> init() async {
    await recorderRepository.initialize();
  }

  Future<void> record() async {
    await recorderRepository.record();
    Stream<String> timer = recorderRepository.timer;
    emit(Recording(timer));
  }

  Future<void> pause() async {
    await recorderRepository.pause();
  }

  Future<void> resume() async {
    await recorderRepository.resume();
    Stream<String> timer = recorderRepository.timer;
    emit(Recording(timer));
  }

  Future<void> stop() async {
    final String? path = await recorderRepository.stop();
    emit(StopRecording(path));
  }

  Future<void> dispose() async {
    await recorderRepository.dispose();
  }
}
