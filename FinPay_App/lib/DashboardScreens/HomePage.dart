import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:FinPay/DatabaseHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;

  bool isANumber = true;

  void setValidator(valid){
    setState(() {
      isANumber = valid;
    });
  }

  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  // List data = [];

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 28.0,
                color: kThemeColor,
                onPressed: () {
                  // _scaffoldKey.currentState.openDrawer();
                }
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            children: <Widget> [
              Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height*2,
                child: ListView.builder(
                    itemCount: databaseHelper.data.length == 0 ? 0 : databaseHelper.data.length,
                    itemBuilder: (ctx, i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: kContainerColor,
                        elevation: 2.0,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "${databaseHelper.data[i]["username"]}",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  Text(
                                    "${databaseHelper.data[i]["email"]}",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    "${databaseHelper.data[i]["mobilenumber"]}",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(""),
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }
                ),
              ),
              // FadeAnimation(0.1, Text("Welcome to", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 20),),),
              // SizedBox(width: 10,),
              // FadeAnimation(0.3, Row(
              //   children: <Widget>[
              //     Text("Fin", style: TextStyle(color: kThemeColor, fontWeight: FontWeight.bold, fontSize: 40),),
              //     SizedBox(width: 0,),
              //     Text("Pay", style: TextStyle(color: kYellowColor, fontWeight: FontWeight.bold, fontSize: 40),),
              //   ],
              // ),),
              // TRANSFER FUNDS, REQUEST FUNDS
              FadeAnimation(0.7, Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                                height: 900,
                                padding: EdgeInsets.only(top: 10, bottom: 30),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: IconButton(
                                            icon: Icon(Icons.clear, color: Colors.black,),
                                            iconSize: 25,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              // _ufullnameController.clear(); _udescController.clear(); _umobilenumberController.clear();
                                              // _ulocationController.clear(); _uemailController.clear(); _uwebsiteController.clear();
                                              // _ufacebookController.clear(); _ugithubController.clear(); _ulinkedinController.clear();
                                              // _uinstagramController.clear(); _utwitterController.clear();
                                            }
                                        ),
                                        title: Text('Add Funds', style: TextStyle(color: kThemeColor, fontSize: 20),),
                                        trailing: IconButton(
                                            icon: Icon(Icons.check, color: Colors.black,),
                                            iconSize: 25,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              // if (_ufullnameController.text.isNotEmpty || _udescController.text.isNotEmpty || _umobilenumberController.text.isNotEmpty ||
                                              //     _ulocationController.text.isNotEmpty || _uemailController.text.isNotEmpty || _uwebsiteController.text.isNotEmpty ||
                                              //     _ufacebookController.text.isNotEmpty || _ugithubController.text.isNotEmpty || _ulinkedinController.text.isNotEmpty ||
                                              //     _uinstagramController.text.isNotEmpty || _utwitterController.text.isNotEmpty) {
                                              //   Firestore.instance
                                              //       .collection("Users")
                                              //       .document(currentUser.uid)
                                              //       .setData({
                                              //     "uid": currentUser.uid,
                                              //     "fullname": _ufullnameController.text,
                                              //     "udesc": _udescController.text,
                                              //     "umobilenumber": _umobilenumberController.text,
                                              //     "ulocation": _ulocationController.text,
                                              //     "uemail": _uemailController.text,
                                              //     "uwebsite": _uwebsiteController.text,
                                              //     "ufacebook": _ufacebookController.text,
                                              //     "ugithub": _ugithubController.text,
                                              //     "ulinkedin": _ulinkedinController.text,
                                              //     "uinstagram": _uinstagramController.text,
                                              //     "utwitter": _utwitterController.text,
                                              //   })
                                              //       .then((result) => {
                                              //     print('successfully updated'),
                                              //     Navigator.pop(context),
                                              //   })
                                              //       .catchError((e) => {
                                              //     print(e),
                                              //     showDialog(context: context,
                                              //         child: AlertDialog(
                                              //           title: Text('Update something'),
                                              //         ))
                                              //   });
                                              //   _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Profile updated successfully!')));
                                              // }
                                            }
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                          padding: EdgeInsets.only(top:20, bottom: 20, left: 20, right: 20),
                                          child: Column(
                                            children: <Widget>[
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.attach_money_rounded, size: 20,),
                                                  labelText: 'Enter Amount',
                                                  hintText: 'Ex. 123.45',
                                                  errorText: isANumber ? null : "Please enter a number",
                                                ),
                                                keyboardType: TextInputType.number,
                                              ),
                                            ],
                                          )
                                      )
                                    ],
                                  ),
                                )
                            );
                          }
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 110,
                      width: 160,
                      decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kYellowColor,
                            ),
                            child: Icon(Icons.check_circle, color: Colors.black,),
                          ),
                          SizedBox(height: 20,),
                          Text("Transfer Funds", style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 110,
                      width: 160,
                      decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kYellowColor,
                            ),
                            child: Icon(Icons.monetization_on, color: Colors.black,),
                          ),
                          SizedBox(height: 20,),
                          Text("Request Funds", style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),),
              SizedBox(height: 10,),
              // WITHDRAW FUNDS, GET STATEMENT
              FadeAnimation(0.9, Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 110,
                      width: 160,
                      decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kYellowColor,
                            ),
                            child: Icon(Icons.published_with_changes_rounded, color: Colors.black,),
                          ),
                          SizedBox(height: 20,),
                          Text("Withdraw Funds", style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 110,
                      width: 160,
                      decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kYellowColor,
                            ),
                            child: Icon(Icons.assignment_rounded, color: Colors.black,),
                          ),
                          SizedBox(height: 20,),
                          Text("Get Statement", style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),),
              SizedBox(height: 30,),
              FadeAnimation(1.1, Text("For adding, withdrawing, requesting money, your balance will reflect transactions that have not yet been posted to your acount. For checking funds, the balance will reflect the lastest update as per transactions.", style: TextStyle(color: Colors.grey),)),
            ]
        ),
      )
    );
  }
}

