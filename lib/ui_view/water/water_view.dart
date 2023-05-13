import 'package:fit_app/google_fit_api/water_api.dart';
import 'package:fit_app/ui_view/wave_view.dart';
import 'package:fit_app/health_app_theme.dart';
import 'package:fit_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health/health.dart';

import '../../google_fit_api/health.dart';

class WaterView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? mainScreenAnimation;
  final double waterPoints;
  const WaterView(
      {Key? key, this.animationController, this.mainScreenAnimation, required this.waterPoints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - mainScreenAnimation!.value), 0.0),
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 3),
                                      child: Text(
                                        waterPoints.toStringAsFixed(1),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: HealthAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 32,
                                          color: HealthAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 8),
                                      child: Text(
                                        'ml',
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, top: 2, bottom: 14),
                                  child: Text(
                                    'Mục tiêu hằng ngày 5.5L',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: HealthAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      color: HealthAppTheme.darkText,
                                    ),
                                  ),
                                ),
                                ElevatedButton(onPressed: () {
                                  final myController = TextEditingController();
                                  showCupertinoDialog(context: context, builder: (context) {
                                    return  AlertDialog(
                                      title: Text("Bạn đã uống thêm nước?"),
                                      titleTextStyle:
                                      TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,fontSize: 20),
                                      actionsOverflowButtonSpacing: 20,
                                      actions: [
                                        ElevatedButton(onPressed: (){Navigator.of(context).pop();
                                        }, child: Text("Quay lại"),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.purple)
                                        ),),
                                        ElevatedButton(onPressed: (){
                                          WaterAPI().addWater(double.parse(myController.text)).then((value) => {
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
                                        }, child: Text("Cập nhật")),
                                      ],
                                      content: TextField(
                                        controller: myController,
                                        decoration: new InputDecoration(labelText: 'Vui lòng nhập chỉ số mới (ml)'),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ], // Only numbers can be entered
                                      ),
                                    );
                                  });
                                }, child: Text('Cập nhật'))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 8, bottom: 16),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: HealthAppTheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Icon(
                                          Icons.access_time,
                                          color: HealthAppTheme.grey
                                              .withOpacity(0.5),
                                          size: 16,
                                        ),
                                      ),
                                      Padding(

                                        padding:
                                        const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Cố lên bạn nhé',
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                              'assets/fitness_app/bell.png'),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Nhớ châm nước thường xuyên bạn nhé',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily:
                                              HealthAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: HexColor('#F65283'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 16, right: 8, top: 16),
                        child: Container(
                          width: 60,
                          height: 160,
                          decoration: BoxDecoration(
                            color: HexColor('#E8EDFE'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(80.0),
                                bottomLeft: Radius.circular(80.0),
                                bottomRight: Radius.circular(80.0),
                                topRight: Radius.circular(80.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: HealthAppTheme.grey.withOpacity(0.4),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4),
                            ],
                          ),
                          child: WaveView(
                            percentageValue: waterPoints*100/2500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
