/// Stores the the number of reps and sets, and the work, rest, and break time
/// for a timer. This class serves as a data transfer object between the timer
/// durations picker form and other areas of the app.
class TimerDurationsDTO {
  double sets;
  double reps;
  double workSeconds;
  double restSeconds;
  double breakMinutes;
  double breakSeconds;

  TimerDurationsDTO(
      {required this.sets,
      required this.reps,
      required this.workSeconds,
      required this.restSeconds,
      required this.breakMinutes,
      required this.breakSeconds});

  /// Assigns a set of standard values that can be used as a starting point when
  /// the use is performing the timer configuration
  TimerDurationsDTO.standard()
      : sets = 1,
        reps = 1,
        workSeconds = 10,
        restSeconds = 5,
        breakMinutes = 0,
        breakSeconds = 30;

  /// Returns a Duration object with workSeconds duration
  Duration get workDuration => Duration(seconds: workSeconds.toInt());

  /// Returns a Duration object with restSeconds duration
  Duration get restDuration => Duration(seconds: restSeconds.toInt());

  /// Returns a Duration object with breakMinutes + breakSeconds duration
  Duration get breakDuration =>
      Duration(minutes: breakMinutes.toInt(), seconds: breakSeconds.toInt());
}
