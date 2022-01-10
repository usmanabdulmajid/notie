abstract class IRecorderRepository {
  Future record();
  Future pause();
  Future resume();
  Future<String?> stop();
  Future<void> initialize();
  Future<void> dispose();
  Stream<String> get timer;
}
