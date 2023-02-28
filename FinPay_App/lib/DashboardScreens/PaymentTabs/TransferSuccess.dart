import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            height: 450,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xFFf4f8fd),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.verified_rounded, size: 70,),
                SizedBox(height: 20,),
                Text("Transfer Success", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("Here are your invoice, thank you!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),),
                SizedBox(height: 15,),
                Divider(height: 20, color: Colors.black,),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Transfer Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                    Text("28 Feb 2023", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Sender", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                    Text("Benita Rego", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Receiver", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                    Text("Nolita Rego", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Transfer Amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                    Text('INR 2000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Additional Fee", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                    Text("INR 10", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),),
                    Text("INR 2010", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
