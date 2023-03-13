import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:FinPay/DashboardScreens/PaymentTabs/TransferSuccess.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtherCards extends StatefulWidget {
  const OtherCards({Key? key}) : super(key: key);

  @override
  State<OtherCards> createState() => _OtherCardsState();
}

class _OtherCardsState extends State<OtherCards> {
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

  //Make multiple cards like Apple Wallet
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height*2,
        child: ListView.builder(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                itemCount: walletData.length,
                itemBuilder: (context, index) {
                  return FadeAnimation(0.5, Slidable(
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Use',
                        color: kContainerColor,
                        icon: Icons.arrow_back_ios_rounded,
                        closeOnTap: true,
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Payment done successfully!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 18.0);
                        },
                      )
                    ],
                    dismissal: SlidableDismissal(
                        child: SlidableDrawerDismissal()),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: kContainerColor,
                        elevation: 2.0,
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(padding: EdgeInsets.all(10), height: 50, width: 50, child: Image.asset("assets/${walletData[index].logo}")),
                              // subtitle: Padding(padding: EdgeInsets.only(top: 5, bottom: 5), child: Text(walletData[index].name,  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),),
                              trailing: Container(width: 100, height: 50,),
                            ),
                            ListTile(
                              title: Padding(padding: EdgeInsets.only(top: 10), child: Text(walletData[index].card_number,  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),),
                              trailing: Container(
                                padding: EdgeInsets.only(bottom: 15, top: 10),
                                // alignment: Alignment.center,
                                child: Text(walletData[index].card_type, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                              ),
                            )
                          ],
                        )
                    ),
                  ));
                }
            ),
      )
    );
  }
}

final List<WalletData> walletData = [
  WalletData(name: 'Bank of America', logo: 'bofa.png', card_number: '****4433', card_type: "VISA"),
  WalletData(name: 'Chase Bank', logo: 'chase.png', card_number: '****9922', card_type: "VISA"),
  WalletData(name: 'Discover', logo: 'discover.png', card_number: '****8877', card_type: "DISCOVER"),
  WalletData(name: 'Apple Card', logo: 'apple.png', card_number: '****1166', card_type: "mastercard"),
];

class WalletData {
  final String name;
  final String logo;
  final String card_number;
  final String card_type;

  WalletData({
    required this.name,
    required this.logo,
    required this.card_number,
    required this.card_type
});
}
