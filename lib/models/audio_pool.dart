import 'dart:developer';
import 'package:just_audio/just_audio.dart';

/// Uses the just_audio package to create a pool of audio players that can be
/// loaded and played
class AudioPool {
  final List<AudioPlayer> _players = [];

  /// Indicates which players are currently playing
  final List<bool> _isPlaying = [];

  /// Adds an audio asset to the pool and returns the index of that player.
  /// Returns -1 if an error occurs while adding audio asset.
  int addAsset(String assetPath) {
    try {
      _players.add(AudioPlayer());
      _isPlaying.add(false); // Set as initially not playing

      int playerIndex = _players.length - 1;
      _players[playerIndex].setAsset(assetPath);
      _players[playerIndex].load();

      return playerIndex;
    } on Exception catch (e) {
      log(e.toString());
      return -1;
    }
  }

  /// Plays the audio asset at the given index in the pool. Will not play the
  /// same asset if it is already being played.
  void play(int index) async {
    if (!_isPlaying[index]) {
      _isPlaying[index] = true;
      await _players[index].seek(Duration.zero);
      await _players[index].play();
      _isPlaying[index] = false;
    }
  }
}
