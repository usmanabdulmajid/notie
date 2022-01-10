abstract class IRecoder {
  void init();
  void dispose();
  Future record();
  Future pause();
  Future<String?> stop();
  Future resume();
}
