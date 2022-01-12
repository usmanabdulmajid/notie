part of 'recoder_cubit.dart';

abstract class RecoderState extends Equatable {
  const RecoderState();

  @override
  List<Object> get props => [];
}

class RecoderInitial extends RecoderState {}

class Recording extends RecoderState {
  final String timer;
  const Recording(this.timer);

  @override
  List<Object> get props => [timer];
}

class StopRecording extends RecoderState {
  final String? path;
  const StopRecording(this.path);
  @override
  List<Object> get props => [path!];
}
