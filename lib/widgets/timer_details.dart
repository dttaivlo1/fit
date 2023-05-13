import 'package:flutter/material.dart';
import '../models/timer_durations_dto.dart';
import '../widgets/progress_counter.dart';
import '../widgets/time_text_row.dart';

/// Displays details about the timer's current work, rest, and break durations,
/// and the number of sets and reps left
class TimerDetails extends StatefulWidget {
  final TimerDurationsDTO timerDurations;
  final int currentSet;
  final int currentRep;

  const TimerDetails(
      {super.key,
      required this.timerDurations,
      required this.currentSet,
      required this.currentRep});

  @override
  State<TimerDetails> createState() => _TimerDetailsState();
}

class _TimerDetailsState extends State<TimerDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _timerDurationInfo(),
        ),
        const VerticalDivider(
          thickness: 1.5,
          indent: 5.0,
          endIndent: 5.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _setRepStatus(),
          ),
        ),
      ],
    );
  }

  /// A widget containing the current rep and set status info
  Widget _setRepStatus() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProgressCounter(
              completed: widget.currentSet - 1,
              total: widget.timerDurations.sets.toInt(),
              title: 'Sets ',
              fontSize: constraints.maxHeight / 5),
          ProgressCounter(
              completed: widget.currentRep - 1,
              total: widget.timerDurations.reps.toInt(),
              title: 'Reps ',
              fontSize: constraints.maxHeight / 5),
        ],
      );
    });
  }

  /// A widget containing information about the work, rest, and break durations
  Widget _timerDurationInfo() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TimeTextRow(
              title: 'Thực hiện ',
              durationString:
                  durationString(widget.timerDurations.workDuration),
              fontSize: constraints.maxHeight / 6,
              titleWidth: 50.0),
          TimeTextRow(
              title: 'Ngắt ',
              durationString:
                  durationString(widget.timerDurations.restDuration),
              fontSize: constraints.maxHeight / 6,
              titleWidth: 50.0),
          TimeTextRow(
              title: 'Nghỉ ',
              durationString:
                  durationString(widget.timerDurations.breakDuration),
              fontSize: constraints.maxHeight / 6,
              titleWidth: 50.0),
        ],
      );
    });
  }

  /// Converts the given duration into a string with format 'M:SS'
  String durationString(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    return '$minutes:${(seconds).toString().padLeft(2, '0')}';
  }
}