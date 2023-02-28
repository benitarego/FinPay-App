import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:FinPay/DashboardScreens/PaymentTabs/RequestPayment.dart';
import 'package:FinPay/DashboardScreens/PaymentTabs/SendPayment.dart';


class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage>  with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  late TabController _nestedTabController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _nestedTabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return loading ? Loading() : MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Payments', textAlign: TextAlign.center, style: TextStyle(color: kThemeColor),),
          centerTitle: true,
          elevation: 0.0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 28.0,
              color: kThemeColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications_none),
              iconSize: 28.0,
              color: kThemeColor,
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TabBar(
                  controller: _nestedTabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: kYellowColor), //Chang
                  indicatorColor: kYellowColor,
                  labelColor: Colors.white,
                  unselectedLabelColor: kThemeColor,
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(text: 'Send'),
                    Tab(text: 'Request'),
                  ],
                ),
                Container(
                  height: screenHeight*0.73,
                  child: TabBarView(
                    controller: _nestedTabController,
                    children: <Widget>[
                      SendPayment(),
                      RequestPayment()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
