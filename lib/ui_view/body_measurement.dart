
import 'package:fit_app/health_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health/health.dart';

import '../google_fit_api/health.dart';

class BodyMeasurementView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final List<HealthDataPoint> healthPoints;
  const BodyMeasurementView({Key? key, this.animationController, this.animation, required this.healthPoints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<HealthDataPoint> height = healthPoints.where((element) => element.type.toString().contains('HEIGHT')).toList();
    List<HealthDataPoint> weight = healthPoints.where((element) => element.type.toString().contains('WEIGHT')).toList();
    List<HealthDataPoint> fat = healthPoints.where((element) => element.type.toString().contains('FAT')).toList();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: HealthAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: HealthAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 4, bottom: 8, top: 16),
                            child: Text(
                              'Cân nặng',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: HealthAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: HealthAppTheme.darkText),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 3),
                                    child: Text(
                                      weight.last.value.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: HealthAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 32,
                                        color: HealthAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8, bottom: 8),
                                    child: Text(
                                      'Kg',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: HealthAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: HealthAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        color: HealthAppTheme.grey
                                            .withOpacity(0.5),
                                        size: 16,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Hôm nay 8:26 AM',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                HealthAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: HealthAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ElevatedButton(onPressed: () {
                                        final myController = TextEditingController();
                                         showCupertinoDialog(context: context, builder: (context) {
                                         return  AlertDialog(
                                           title: const Text("Cập nhật cân năng"),
                                           titleTextStyle:
                                           const TextStyle(
                                               fontWeight: FontWeight.bold,
                                               color: Colors.black,fontSize: 20),
                                           actionsOverflowButtonSpacing: 20,
                                           actions: [
                                             ElevatedButton(onPressed: (){Navigator.of(context).pop();
                                             }, child: const Text("Back")),
                                             ElevatedButton(onPressed: (){
                                               HealthFlutter().addWeight(double.parse(myController.text)).then((value) => {
                                                 Fluttertoast.showToast(
                                                     msg: value,
                                                     toastLength: Toast.LENGTH_SHORT,
                                                     gravity: ToastGravity.CENTER,
                                                     timeInSecForIosWeb: 1,
                                                     backgroundColor: Colors.red,
                                                     textColor: Colors.white,
                                                     fontSize: 16.0
                                                 ),
                                               Navigator.of(context).pop(),
                                               });
                                             }, child: const Text("Next")),
                                           ],
                                           content: TextField(
                                             controller: myController,
                                             decoration: new InputDecoration(labelText: 'Vui lòng nhập chỉ số mới (Kg)'),
                                             keyboardType: TextInputType.number,
                                             inputFormatters: <TextInputFormatter>[
                                               FilteringTextInputFormatter.digitsOnly
                                             ], // Only numbers can be entered
                                           ),
                                         );
                                         });
                                      }, child: const Text("Cập nhật"),)

                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 4, bottom: 14),

                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: HealthAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                      height.last.value.toString().substring(0, 4),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: HealthAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: HealthAppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    'Chiều cao',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: HealthAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color:
                                          HealthAppTheme.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      '27.3 BMI',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: HealthAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: HealthAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Chỉ số BMI',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: HealthAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: HealthAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                            fat.last.value.toString()+ ' %',
                                      style: const TextStyle(
                                        fontFamily: HealthAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: HealthAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Lượng mỡ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: HealthAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: HealthAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
