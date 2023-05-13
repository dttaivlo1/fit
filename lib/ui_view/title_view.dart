import 'package:fit_app/google_fit_api/water_api.dart';
import 'package:fit_app/health_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health/health.dart';

import '../Dashboard/dashboard_screen.dart';
import '../Dashboard/hotel_home_screen.dart';
import '../models/hotel_list_view.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final String actionTxt;
  const TitleView(
      {Key? key,
      this.titleTxt: "",
      this.subTxt: "",
      this.animationController,
      this.animation,
      required this.actionTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: HealthAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: HealthAppTheme.lightText,
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {
                      DetailsRouter(actionTxt, context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: HealthAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: HealthAppTheme.nearlyDarkBlue,
                              ),
                            ),
                            const SizedBox(
                              height: 38,
                              width: 26,
                              child: Icon(
                                Icons.arrow_forward,
                                color: HealthAppTheme.darkText,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
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
  DetailsRouter(String action, BuildContext context)  {

    switch(action) {

      case 'waterManager': {
        WaterAPI().GetDrinkingHistory().then((data) => {

        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HotelHomeScreen(healthData: data,))
        )
      });
      }
      break;
      default: {
        Fluttertoast.showToast(
            msg: actionTxt,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      break;
    }
  }
}
