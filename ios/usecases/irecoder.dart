abstract class IRecoder {
  Future<void> init();
  Future<void> dispose();
  Future record();
  Future pause();
  Future<String?> stop();
  Future resume();
  Stream<String> get timer;
}
