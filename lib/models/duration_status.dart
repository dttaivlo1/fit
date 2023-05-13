import 'package:flutter/material.dart';
import 'status_value.dart';

/// Represents a Duration that has an associated status value and color. While
/// the duration is being counted down by the timer, the status value and color
/// can be displayed as an indicator of which phase of the countdown the user is
/// in.
class DurationStatus {
  final Duration duration;
  final StatusValue statusValue;
  Color statusColor;
  final int currSet;
  final int currRep;

  /// The duration elapsed when this object's duration begins. For example, if
  /// this object's duration begins 10 seconds into the workout, then the
  /// startTime will have a Duration value of 10 seconds.
  late Duration startTime;
  DurationStatus(
      {required this.duration,
      required this.statusValue,
      required this.statusColor,
      required this.startTime,
      required this.currSet,
      required this.currRep});
  String get status => statusValue.status.toString().toUpperCase();
  @override
  String toString() {
    int seconds = duration.inSeconds;
    String status = statusValue.status;
    return '($status for $seconds sec)';
  }
}
