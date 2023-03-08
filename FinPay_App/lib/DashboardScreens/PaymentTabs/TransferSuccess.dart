import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:FinPay/DashboardScreens/HomePage.dart';
import 'package:FinPay/ThemeColor.dart';

class TransferSuccess extends StatefulWidget {
  const TransferSuccess({Key? key}) : super(key: key);

  @override
  State<TransferSuccess> createState() => _TransferSuccessState();
}

class _TransferSuccessState extends State<TransferSuccess> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                height: 450,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFf4f8fd),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(0.3, Icon(Icons.verified_rounded, size: 70,),),
                    SizedBox(height: 20,),
                    FadeAnimation(0.4, Text("Transfer Success", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
                    SizedBox(height: 10,),
                    FadeAnimation(0.5, Text("Here are your invoice, thank you!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),),),
                    SizedBox(height: 15,),
                    FadeAnimation(0.6, Divider(height: 20, color: Colors.black,),),
                    SizedBox(height: 15,),
                    FadeAnimation(0.7, Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Transfer Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                        Text("28 Feb 2023", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),),
                    SizedBox(height: 15,),
                    FadeAnimation(0.8, Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Sender", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                        Text("Benita Rego", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),),
                    SizedBox(height: 15,),
                    FadeAnimation(0.9, Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Receiver", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                        Text("Nolita Rego", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),),
                    SizedBox(height: 20,),
                    FadeAnimation(1.0, Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Transfer Amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                        Text('INR 2000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),),
                    SizedBox(height: 15,),
                    FadeAnimation(1.1, Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Additional Fee", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                        Text("INR 10", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),),
                    SizedBox(height: 20,),
                    FadeAnimation(1.2, Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                        Text("INR 2010", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),)
                  ],
                ),
              ),
              SizedBox(height: 30,),
              FadeAnimation(1.3,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MaterialButton(
                      minWidth: 180,
                      height: 50,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context) => HomePage())
                        );
                      },
                      color: kThemeColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("Go to Acccount Home",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                    ),
                  )
              ),
            ],
          )
        )
      ),
    );
  }
}
