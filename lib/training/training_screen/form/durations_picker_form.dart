import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../../../models/timer_durations_dto.dart';

/// A form widget that allows the user to pick the number of sets and reps, and
/// the work, rest, and break durations for the countdown timer.
class DurationsPickerForm extends StatefulWidget {
  /// Function to be called when start button is pressed
  final Function(BuildContext, TimerDurationsDTO) onStartPressed;

  const DurationsPickerForm({super.key, required this.onStartPressed});

  @override
  State<DurationsPickerForm> createState() => _DurationsPickerFormState();
}

class _DurationsPickerFormState extends State<DurationsPickerForm> {
  final timerDurations = TimerDurationsDTO.standard();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SpinBox(
            value: timerDurations.sets,
            min: 1,
            max: 20,
            onChanged: (value) {
              setState(() {
                // Do not allow value of zero or lower
                if (value <= 0) {
                  timerDurations.sets = 1;
                } else {
                  timerDurations.sets = value;
                }
              });
            },
            decoration: const InputDecoration(
                labelText: 'Số bài tập', labelStyle: TextStyle(fontSize: 24.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SpinBox(
            value: timerDurations.reps,
            min: 1,
            max: 20,
            onChanged: (value) {
              setState(() {
                // Do not allow value of zero or lower
                if (value <= 0) {
                  timerDurations.reps = 1;
                } else {
                  timerDurations.reps = value;
                }
              });
            },
            decoration: const InputDecoration(
                labelText: 'Lặp lại', labelStyle: TextStyle(fontSize: 24.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SpinBox(
            value: timerDurations.workSeconds,
            min: 1,
            max: 60,
            onChanged: (value) {
              setState(() {
                timerDurations.workSeconds = value;
              });
            },
            decoration: const InputDecoration(
                labelText: 'Thực hiện (giây)', labelStyle: TextStyle(fontSize: 24.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SpinBox(
            value: timerDurations.restSeconds,
            min: 1,
            max: 60,
            onChanged: (value) {
              setState(() {
                timerDurations.restSeconds = value;
              });
            },
            decoration: const InputDecoration(
                labelText: 'Nghỉ (giây)', labelStyle: TextStyle(fontSize: 24.0)),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                child: SpinBox(
                  value: timerDurations.breakMinutes,
                  min: 0,
                  max: 30,
                  onChanged: (value) {
                    setState(() {
                      timerDurations.breakMinutes = value;
                    });
                  },
                  decoration: const InputDecoration(
                      labelText: 'Gia lao (phút)',
                      labelStyle: TextStyle(fontSize: 24.0)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 16.0),
                child: SpinBox(
                  value: timerDurations.breakSeconds,
                  min: 0,
                  max: 60,
                  onChanged: (value) {
                    setState(() {
                      timerDurations.breakSeconds = value;
                    });
                  },
                  decoration: const InputDecoration(
                      labelText: 'giải lao (giây)',
                      labelStyle: TextStyle(fontSize: 24.0)),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              widget.onStartPressed(context, timerDurations);
            },
            child: const Text(
              'Bắt đầu',
              style: TextStyle(fontSize: 20.0),
            )
          ),
        ),
      ],
    );
  }
}
