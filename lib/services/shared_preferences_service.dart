import 'package:shared_preferences/shared_preferences.dart';

/// Provides a set of methods used to set and get a variety of shared
/// preferences values stored locally on the device
class SharedPreferencesService {
  final SharedPreferences sharedPreferences;

  /// Indicates if timer sound is turned on
  static const soundOnKey = 'countdownTimerSoundOn';

  /// Indicates if timer vibration is turned on
  static const vibrationOnKey = 'countdownTimerVibrationOn';

  /// Indicates if dark mode is turned on
  static const darkModeOnKey = 'countdownTimerDarkModeOn';

  SharedPreferencesService({required this.sharedPreferences});

  /// Sets the timer sound on value
  void setSoundOn(bool newValue) {
    sharedPreferences.setBool(soundOnKey, newValue);
  }

  /// Gets the sound on value or false if key has not yet been set
  bool getSoundOn() {
    return sharedPreferences.getBool(soundOnKey) ?? false;
  }

  /// Sets the timer vibration on value
  void setVibrationOn(bool newValue) {
    sharedPreferences.setBool(vibrationOnKey, newValue);
  }

  /// Gets the vibration on value or false if key has not yet been set
  bool getVibrationOn() {
    return sharedPreferences.getBool(vibrationOnKey) ?? false;
  }

  /// Sets the dark mode on on value
  void setDarkModeOn(bool newValue) {
    sharedPreferences.setBool(darkModeOnKey, newValue);
  }

  /// Gets the dark mode on value or false if key has not yet been set
  bool getDarkModeOn() {
    return sharedPreferences.getBool(darkModeOnKey) ?? false;
  }
}
