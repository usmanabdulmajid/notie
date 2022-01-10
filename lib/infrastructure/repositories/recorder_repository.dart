import 'package:notie/domain/usecases/irecoder.dart';
import 'package:notie/infrastructure/repositories/irecorder_repository.dart';

class RecorderRepository implements IRecorderRepository {
  final IRecoder recoder;
  RecorderRepository(this.recoder);

  @override
  Future<void> initialize() async {
    await recoder.init();
  }

  @override
  Future pause() async {
    await recoder.pause();
  }

  @override
  Future record() async {
    await recoder.record();
  }

  @override
  Future resume() async {
    await recoder.resume();
  }

  @override
  Future<String?> stop() async {
    return await recoder.stop();
  }

  @override
  Stream<String> get timer => recoder.timer;

  @override
  Future<void> dispose() async {
    await recoder.dispose();
  }
}
