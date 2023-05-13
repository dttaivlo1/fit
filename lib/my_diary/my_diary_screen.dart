import 'package:fit_app/google_fit_api/water_api.dart';
import 'package:fit_app/ui_view/body_measurement.dart';
import 'package:fit_app/ui_view/calories_burn_history.dart';
import 'package:fit_app/ui_view/glass_view.dart';
import 'package:fit_app/ui_view/mediterranean_diet_view.dart';
import 'package:fit_app/ui_view/title_view.dart';
import 'package:fit_app/health_app_theme.dart';
import 'package:fit_app/my_diary/meals_list_view.dart';
import 'package:fit_app/ui_view/water/water_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';

import '../google_fit_api/health.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  Future<List<HealthDataPoint>>  healthData = HealthFlutter().fetchData();
  Future<List<HealthDataPoint>>  foodData = HealthFlutter().fetchFood();
  Future<double>  WaterData = WaterAPI().fetchWater();

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
     GestureDetector(
       onTap: (){
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => const CaloriesBurn()),
         );
       },
       child:
       TitleView(
actionTxt: 'nutritionManager',
         titleTxt: 'Dinh dưỡng',
         subTxt: 'Chi tiết',
         animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
             parent: widget.animationController!,
             curve:
             Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
         animationController: widget.animationController!,
       )
     ));
    listViews.add(
        FutureBuilder<List<HealthDataPoint>>(
          future: foodData,
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                return  MediterranesnDietView(
                  animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: widget.animationController!,
                      curve:
                      Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
                  animationController: widget.animationController!,
                  healthDataPoints: snapshot.data!,
                );
              }
            }
            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
    listViews.add(
      TitleView(
        actionTxt: 'mealToday',
        titleTxt: 'Bữa ăn hôm nay',
        subTxt: 'Chỉnh sửa',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        actionTxt: 'bodyIndex',
        titleTxt: 'Chỉ số cơ thể',
        subTxt: 'Chi tiết',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );



    listViews.add(
        FutureBuilder<List<HealthDataPoint>>(
          future: healthData,
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError || snapshot.data==null) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                return  BodyMeasurementView(
                  animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: widget.animationController!,
                      curve:
                      Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
                  animationController: widget.animationController!,
                  healthPoints: snapshot.data!,
                );
              }
            }
            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
    listViews.add(
     GestureDetector(
       onTap: () {
         Fluttertoast.showToast(
             msg: "đawa",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.red,
             textColor: Colors.white,
             fontSize: 16.0
         );
       },
       child:  TitleView(
         actionTxt: 'waterManager',
         titleTxt: 'Nước',
         subTxt: 'Quản lý',
         animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
             parent: widget.animationController!,
             curve:
             Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
         animationController: widget.animationController!,
       ),
     )
    );

    listViews.add(
        FutureBuilder<double>(
          future: WaterData,
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object

                return   WaterView(
                  mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.animationController!,
                          curve: Interval((1 / count) * 7, 1.0,
                              curve: Curves.fastOutSlowIn))),
                  animationController: widget.animationController!,
                  waterPoints: snapshot.data!,
                );

              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
    );
    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController!),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HealthAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HealthAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: HealthAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    onPressed:() => HealthFlutter().authorize(),
                                    child:
                                    Text("Auth", style: TextStyle(color: Colors.white)),
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue))),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: HealthAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),

                                  ),
                                  Text(
                                    DateFormat('dd/MMM/yyyy').format(DateTime.now()),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: HealthAppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      letterSpacing: -0.2,
                                      color: HealthAppTheme.darkerText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: HealthAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
