abstract class IAudioPlayer {
  Future<void> init();
  Future<void> dispose();
  Future play(String path);
  Future pause();
}
