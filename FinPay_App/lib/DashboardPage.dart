import 'package:FinPay/DashboardScreens/HomePage.dart';
import 'package:FinPay/DashboardScreens/PaymentsPage.dart';
import 'package:FinPay/DashboardScreens/ProfilePage.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int pageIndex = 0;
  bool loading = false;

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return HomePage();
        break;
      case 1:
        return PaymentsPage();
        break;
      case 2:
        return ProfilePage();
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text('No page found', style: TextStyle(fontSize: 30),),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          color: kThemeColor,
          backgroundColor: Colors.white,
          buttonBackgroundColor: kYellowColor,
          items: <Widget>[
            Icon(Icons.home, color: Colors.black,),
            Icon(Icons.attach_money_rounded, color: Colors.black,),
            Icon(Icons.person, color: Colors.black,),
          ],
          animationDuration: Duration(milliseconds: 400),
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: _showPage,
          ),
        ),
      ),
    );
  }
}
