import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 64, right: 64, top: 130, bottom: 0),
              child: Text(
                "Xin chào!",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 64, right: 64, bottom: 23),
              child: Text(
                "Ứng dụng đang khởi động",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                "Có sức khỏe chúng ta có thể tạo ra vàng bạc, của cải, tạo ra mọi thứ và ngược lại. Và đương nhiên, dù bạn có nhiều tiền, nhiều vàng đến đâu thì cũng sẽ không thể mua được sức khỏe",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(

              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 20, bottom: 50),
              child: SizedBox(
                child: Image.asset(
                  width: 150,
                  'assets/introduction_animation/introduction_image.png',
                  fit: BoxFit.cover,
                ),
              )
            ),


            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: Color(0xff132137),
                  ),
                  child: Text(
                    "Bắt đầu",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
