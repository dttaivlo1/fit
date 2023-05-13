import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';

import '../../AppColors.dart';

class BarChartSample1 extends StatefulWidget {
  const BarChartSample1({super.key, required this.healthDataList});
final List<HealthDataPoint> healthDataList;
  List<Color> get availableColors => const <Color>[
    AppColors.contentColorPurple,
    AppColors.contentColorYellow,
    AppColors.contentColorBlue,
    AppColors.contentColorOrange,
    AppColors.contentColorPink,
    AppColors.contentColorRed,
  ];

  final Color barBackgroundColor =
  AppColors.contentColorWhite;
  final Color barColor = AppColors.contentColorGreen;
  final Color touchedBarColor = AppColors.contentColorPurple;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: new BoxDecoration( color: Colors.white12),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
               Text(
                    'Ngày ' +DateFormat('dd/MM/yyyy').format(widget.healthDataList[0].dateTo),
                    style: TextStyle(
                      color: AppColors.contentColorPurple,
                      fontSize: 24,

                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Tổng lượng nước',
                    style: TextStyle(
                      color: AppColors.contentColorBlack,
                      fontSize: 18,

                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        mainBarData(),

                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.contentColorGreen,
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        refreshState();

                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color? barColor,
        double width = 16,
        List<int> showTooltips = const [],
      }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.red, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
  List<BarChartGroupData> showingGroups(){
    List<BarChartGroupData> temp = [];
    for(int i=0; i < 24 ; i++){
      double sumEachHour = 0;
      int a = 0;
      widget.healthDataList.forEach((element) => {
        if(element.dateTo.hour == i){
          sumEachHour += double.parse((element.value).toString()),
          a = i
        }
        else{
        }
      });
     if(a != 0){
       temp.add(makeGroupData(a, sumEachHour*1000, isTouched: i == touchedIndex));
     }
    }
    return temp;
  }


  BarChartData mainBarData() {
    return BarChartData(
      backgroundColor: Colors.grey,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Thứ Hai';
                break;
              case 1:
                weekDay = 'TThứ 3';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toStringAsFixed(2) + "ml",
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,

                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );

  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.red,
      fontSize: 14,
    );
    const styleNow = TextStyle(
      color: Colors.deepPurpleAccent,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    Widget text;
    DateTime now = DateTime.now();
switch (value.toInt()) {
  case 0:
    text = Text(value.toString());
    break;
  case 1:
    text = Text(value.toString());
    break;
    default:
      text = Text(value.toString());

}

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor:Colors.black,
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
              Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
              Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
              Random().nextInt(widget.availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
              Random().nextInt(widget.availableColors.length)],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
              Random().nextInt(widget.availableColors.length)],
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
              Random().nextInt(widget.availableColors.length)],
            );
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 40),
    );

    if (isPlaying) {
      await refreshState();

    }
  }
}