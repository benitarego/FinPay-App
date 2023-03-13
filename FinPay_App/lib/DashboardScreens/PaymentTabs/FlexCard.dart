import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:FinPay/DashboardScreens/PaymentTabs/TransferSuccess.dart';
import 'package:FinPay/FadeAnimation.dart';

class FlexCard extends StatefulWidget {
  const FlexCard({Key? key}) : super(key: key);

  @override
  State<FlexCard> createState() => _FlexCardState();
}

class _FlexCardState extends State<FlexCard> {
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


  //Make Flex Card and write amount in that, (scu authentication required)
  //Add an authentication for SCU and then display amount in the card
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(0.5, Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: kThemeColor,
                  elevation: 2.0,
                  child: Column(
                    children: [
                      ListTile(
                        title: Padding(padding: EdgeInsets.only(top: 10), child: Text("FLEX", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),),
                        subtitle: Padding(padding: EdgeInsets.only(top: 5, bottom: 5), child: Text("Individual",  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),),),
                        trailing: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 10),
                          // alignment: Alignment.center,
                          child: Text("USD 0.00", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(kYellowColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  )
                              )
                          ),
                          child: const Text('ADD FUNDS', style: TextStyle(color: Colors.white, fontSize: 16),),
                          onPressed: () {},
                        ),
                      )
                    ],
                  )
              ),),
              SizedBox(height: 10,),
              FadeAnimation(0.7,
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 28.0),
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
            ],
          ),
        ),
      )
    );
  }
}
