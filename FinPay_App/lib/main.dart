import 'package:FinPay/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState() {
    _mockCheckForSession().then((status) {
      if (status) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterPage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterPage()));
      }
      super.initState();
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    return true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 1.0,
                  child: Image.asset('assets/logo_black.png', width: 120.0, height: 120.0,),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.white30,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "FinPay",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          fontFamily: 'NotoSansHK'
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
