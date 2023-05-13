import 'package:flutter/material.dart';

/// A widget that contains the Start, Reset, and Skip buttons that can change
/// depending on the state of the timer
class TimerControlButtons extends StatefulWidget {
  final bool hasStarted;
  final bool isPaused;
  final Function startTimer;
  final Function pauseTimer;
  final Function resumeTimer;
  final Function resetTimer;
  final Function skipDuration;

  const TimerControlButtons(
      {super.key,
      required this.hasStarted,
      required this.isPaused,
      required this.startTimer,
      required this.pauseTimer,
      required this.resumeTimer,
      required this.resetTimer,
      required this.skipDuration});

  @override
  State<TimerControlButtons> createState() => _TimerControlButtonsState();
}

class _TimerControlButtonsState extends State<TimerControlButtons> {
  @override
  Widget build(BuildContext context) {
    // Only show Start button if timer has not started yet
    if (widget.hasStarted) {
      if (widget.isPaused) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(40)),
                  onPressed: () {
                    widget.resumeTimer();
                  },
                  child:
                      const Text('Tiếp tục', style: TextStyle(fontSize: 20.0))),
            ),
            resetAndSkipButtons(),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade700,
                      minimumSize: const Size.fromHeight(40)),
                  onPressed: () {
                    widget.pauseTimer();
                  },
                  child: const Text('Tạm dừng', style: TextStyle(fontSize: 20.0))),
            ),
            resetAndSkipButtons(),
          ],
        );
      }
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () {
                widget.startTimer();
              },
              child: const Text('Bắt đầu', style: TextStyle(fontSize: 20.0))),
        ),
      );
    }
  }

  /// Defines a Widget containing the Reset and Skip buttons
  Widget resetAndSkipButtons() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size.fromHeight(40)),
                onPressed: () {
                  widget.resetTimer();
                },
                child: const Text('Đặt lại', style: TextStyle(fontSize: 20.0))),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size.fromHeight(40)),
                onPressed: () {
                  widget.skipDuration();
                },
                child: const Text('Bỏ qua', style: TextStyle(fontSize: 20.0))),
          ),
        ),
      ],
    );
  }
}
