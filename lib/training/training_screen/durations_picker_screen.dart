import 'package:flutter/material.dart';
import 'countdown_timer_screen.dart';
import './form/durations_picker_form.dart';
import '../../models/timer_durations_dto.dart';

/// A screen with a form that allows the user to choose the work, rest, and
/// break durations in addition to the number or reps and sets.
class DurationsPickerScreen extends StatefulWidget {
  final String name;
  const DurationsPickerScreen({super.key, required this.name});
  @override
  State<DurationsPickerScreen> createState() => _DurationsPickerScreenState(this.name);
}

class _DurationsPickerScreenState extends State<DurationsPickerScreen> {
 String name = '';

   _DurationsPickerScreenState(String name){
    this.name = name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text('Thiết lập thời gian '+name),
        ),
        body: const DurationsPickerForm(onStartPressed: navigateToTimer));
  }

  /// Navigates to the countdown timer screen
  static navigateToTimer(
      BuildContext context, TimerDurationsDTO timerDurations) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CountdownTimerScreen(timerDurations: timerDurations)),
    );
  }
}
