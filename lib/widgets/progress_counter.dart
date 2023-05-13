import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
/// Displays a horizontal progress bar that depicts the number of reps/sets
/// completed compared to the total reps/sets
class ProgressCounter extends StatelessWidget {
  final int completed;
  final int total;
  final String title;
  final double fontSize;

  const ProgressCounter(
      {super.key,
      required this.completed,
      required this.total,
      required this.title,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 48,
          child: Text(
            title,
            style: TextStyle(color: Colors.grey.shade700, fontSize: fontSize),
          ),
        ),
        Expanded(
          child: StepProgressIndicator(
            totalSteps: total,
            currentStep: completed,
            size: 20,
            padding: 1.0,
            selectedColor: Theme.of(context).colorScheme.secondary,
            unselectedColor: Colors.grey.shade300,
            customStep: (index, color, _) {
              return Container(
                decoration: _getCustomDecoration(index, color),
                child: Center(
                    child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: _getCustomText(index),
                )),
              );
            },
          ),
        )
      ],
    );
  }

  /// Returns the approprate Box Decoration based on the current index
  BoxDecoration _getCustomDecoration(int index, Color color) {
    if (completed == index) {
      return BoxDecoration(
          border: Border.all(
              color: Colors.green,
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignCenter),
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
          color: color);
    } else {
      return BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
          color: color);
    }
  }

  /// Returns the appropriate text style based on the current index
  TextStyle _getCustomStyle(int index) {
    if (completed == index) {
      return TextStyle(color: Colors.grey.shade600);
    } else {
      return const TextStyle(color: Colors.white);
    }
  }

  /// Returns text representing the current set/rep only if the total sets/reps
  /// if below a certain number. Otherwise, returns a blank text. This prevents
  /// the counter from showing unreadably small text.
  Text _getCustomText(int index) {
    if (total <= 15) {
      return Text(
        '${index + 1}',
        style: _getCustomStyle(index),
      );
    } else {
      return Text(
        ' ', // Blank because not enough room to show text
        style: _getCustomStyle(index),
      );
    }
  }
}
