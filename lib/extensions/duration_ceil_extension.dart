extension DurationCeilExtension on Duration {
  /// Rounds the time of this duration up to the nearest multiple of [to].
  /// Borrowed from:
  /// https://stackoverflow.com/questions/59801869/rounding-a-duration-to-the-nearest-second-based-on-desired-precision
  Duration ceil(Duration to) {
    int us = inMicroseconds;
    int toUs = to.inMicroseconds.abs(); // Ignore if [to] is negative.
    int mod = us % toUs;
    if (mod != 0) {
      return Duration(microseconds: us - mod + toUs);
    }
    return this;
  }
}
