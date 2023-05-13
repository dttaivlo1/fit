import 'package:flutter/material.dart';
import '../../models/timer_durations_dto.dart';
import '../../widgets/countdown_timer.dart';

/// Provides a layout for the countdown timer, timer details, and timer control
/// buttons. Contains the state variable necessary to start a countdown timer.
class CountdownTimerScreen extends StatefulWidget {
  final TimerDurationsDTO timerDurations;
  const CountdownTimerScreen({super.key, required this.timerDurations});
  @override
  State<CountdownTimerScreen> createState() => _CountdownTimerScreenState();
}
class _CountdownTimerScreenState extends State<CountdownTimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ đếm giờ'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 88,
              child: CountdownTimer(
                timerDurations: widget.timerDurations,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
