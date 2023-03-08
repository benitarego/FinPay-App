import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:FinPay/DashboardScreens/PaymentTabs/TransferSuccess.dart';

class WithdrawMoney extends StatefulWidget {
  const WithdrawMoney({Key? key}) : super(key: key);

  @override
  State<WithdrawMoney> createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  Color _iconColor = Colors.yellow;

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: FadeAnimation(0.3,
        Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 28.0),
            height: MediaQuery.of(context).size.height*2,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransferSuccess()));
                },
              ),
            )
        ),
      ),
    );
  }
}
