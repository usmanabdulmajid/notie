abstract class IRecoder {
  void init();
  void dispose();
  Stream<String> record();
  Future pause();
  Future<String?> stop();
  Future resume();
}
