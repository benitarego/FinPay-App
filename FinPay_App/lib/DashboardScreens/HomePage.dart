import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:FinPay/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? username = "";
  String? password = "";
  List<dynamic> users = [];

  void setValidator(valid){
    setState(() {
      isANumber = valid;
    });
  }

  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  Future<void> getUsernamePassword() async{
    final prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username');
    final String password = prefs.getString('password');
    setState(() {
      this.username = username;
      this.password = password;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUsernamePassword().then((_)  {
      Future<Map<String, dynamic>> data = databaseHelper.getUsers(username, password);
      data.then((value) {
        List<dynamic> allusers = [];
        for(var user in value["items"]){
          allusers.add(user);
        }
        setState(() {
          users = allusers;
        });
        print(users);
      });
    });
    super.initState();
  }

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
                            itemCount: users.length,
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
                                          "${users[i]["firstName"]} ${users[i]["lastName"]}",
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                        trailing: Text(
                                          "${users[i]["username"]}",
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        subtitle: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 5,),
                                            Text(
                                              "${users[i]["email"]}",
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            Text(
                                              "${users[i]["mobile"]}",
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

