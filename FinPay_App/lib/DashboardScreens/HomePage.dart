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

  List<UserList> data = [
    UserList(username: 'W1000001', firstName: 'bucky', lastName: 'bronco', email: 'bbronco1@scu.edu', mobile: '1231231231'),
    UserList(username: 'W1000002', firstName: 'bucky', lastName: 'bronco', email: 'bbronco2@scu.edu', mobile: '1231231232'),
    UserList(username: 'W1000003', firstName: 'bucky', lastName: 'bronco', email: 'bbronco3@scu.edu', mobile: '1231231233'),
    UserList(username: 'W1765843', firstName: 'Benita', lastName: 'Rego', email: 'brego@scu.edu', mobile: '9876785643'),
    UserList(username: 'W7658432', firstName: 'Nolita', lastName: 'Rego', email: 'nrego@scu.edu', mobile: '9988776655'),
    UserList(username: 'W1877554', firstName: 'naina', lastName: 'sharma', email: 'nsharma@scu.edu', mobile: '8877440022'),
    UserList(username: 'W9944667', firstName: 'bunny', lastName: 'Yu',email: 'byu@scu.edu',  mobile: '8877447711'),
    UserList(username: 'W8802413', firstName: 'Rohit', lastName: 'Mehra', email: 'rmehra@scu.edu', mobile: '9892348621'),
    UserList(username: 'W9988003', firstName: 'Kabir', lastName: 'Singh', email: 'ksingh@scu.edu', mobile: '6698742309'),

  ];

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
        padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text("Welcome to", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Text("Flex", style: TextStyle(color: kThemeColor, fontSize: 30, fontWeight: FontWeight.bold),),
                  SizedBox(width: 0,),
                  Text("Pay!", style: TextStyle(color: kYellowColor, fontSize: 30, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height*2,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                          itemBuilder: (ctx, i) {
                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: kContainerColor,
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        "${data[i].firstName} ${data[i].lastName}",
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      trailing: Text(
                                        "${data[i].username}",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 5,),
                                          Text(
                                            "${data[i].email}",
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                          Text(
                                            "${data[i].mobile}",
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 30,),
                    FadeAnimation(1.1, Text("For adding, withdrawing, requesting money, your balance will reflect transactions that have not yet been posted to your acount. For checking funds, the balance will reflect the lastest update as per transactions.", style: TextStyle(color: Colors.grey),)),
                  ],
                ),
              )
            ]
        ),
      )
    );
  }
}

class UserList {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;

  UserList({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile
  });
}

