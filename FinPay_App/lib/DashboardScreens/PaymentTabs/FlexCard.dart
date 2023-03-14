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

  bool isANumber = true;

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
                        title: Padding(padding: EdgeInsets.all(10), child: Text("FLEX", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),),
                        subtitle: Padding(padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10), child: Text("Individual",  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),),),
                        trailing: Container(
                          padding: EdgeInsets.all(10),
                          // alignment: Alignment.center,
                          child: Text("USD 0.00", style: TextStyle(color: Colors.greenAccent, fontSize: 25, fontWeight: FontWeight.w600),)
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(10),
                      //   child: ElevatedButton(
                      //     style: ButtonStyle(
                      //         backgroundColor: MaterialStateProperty.all<Color>(kYellowColor),
                      //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //             RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(18.0),
                      //             )
                      //         )
                      //     ),
                      //     child: const Text('ADD FUNDS', style: TextStyle(color: Colors.white, fontSize: 16),),
                      //     onPressed: () {
                      //       showModalBottomSheet(
                      //           context: context,
                      //           builder: (context) {
                      //             return Container(
                      //                 height: 900,
                      //                 padding: EdgeInsets.only(top: 10, bottom: 30),
                      //                 child: SingleChildScrollView(
                      //                   child: Column(
                      //                     children: <Widget>[
                      //                       ListTile(
                      //                         leading: IconButton(
                      //                             icon: Icon(Icons.clear, color: Colors.black,),
                      //                             iconSize: 25,
                      //                             onPressed: () {
                      //                               Navigator.pop(context);
                      //                               // _ufullnameController.clear(); _udescController.clear(); _umobilenumberController.clear();
                      //                               // _ulocationController.clear(); _uemailController.clear(); _uwebsiteController.clear();
                      //                               // _ufacebookController.clear(); _ugithubController.clear(); _ulinkedinController.clear();
                      //                               // _uinstagramController.clear(); _utwitterController.clear();
                      //                             }
                      //                         ),
                      //                         title: Text('Add Funds', style: TextStyle(color: kThemeColor, fontSize: 20),),
                      //                         trailing: IconButton(
                      //                             icon: Icon(Icons.check, color: Colors.black,),
                      //                             iconSize: 25,
                      //                             onPressed: () {
                      //                               Navigator.pop(context);
                      //                               // if (_ufullnameController.text.isNotEmpty || _udescController.text.isNotEmpty || _umobilenumberController.text.isNotEmpty ||
                      //                               //     _ulocationController.text.isNotEmpty || _uemailController.text.isNotEmpty || _uwebsiteController.text.isNotEmpty ||
                      //                               //     _ufacebookController.text.isNotEmpty || _ugithubController.text.isNotEmpty || _ulinkedinController.text.isNotEmpty ||
                      //                               //     _uinstagramController.text.isNotEmpty || _utwitterController.text.isNotEmpty) {
                      //                               //   Firestore.instance
                      //                               //       .collection("Users")
                      //                               //       .document(currentUser.uid)
                      //                               //       .setData({
                      //                               //     "uid": currentUser.uid,
                      //                               //     "fullname": _ufullnameController.text,
                      //                               //     "udesc": _udescController.text,
                      //                               //     "umobilenumber": _umobilenumberController.text,
                      //                               //     "ulocation": _ulocationController.text,
                      //                               //     "uemail": _uemailController.text,
                      //                               //     "uwebsite": _uwebsiteController.text,
                      //                               //     "ufacebook": _ufacebookController.text,
                      //                               //     "ugithub": _ugithubController.text,
                      //                               //     "ulinkedin": _ulinkedinController.text,
                      //                               //     "uinstagram": _uinstagramController.text,
                      //                               //     "utwitter": _utwitterController.text,
                      //                               //   })
                      //                               //       .then((result) => {
                      //                               //     print('successfully updated'),
                      //                               //     Navigator.pop(context),
                      //                               //   })
                      //                               //       .catchError((e) => {
                      //                               //     print(e),
                      //                               //     showDialog(context: context,
                      //                               //         child: AlertDialog(
                      //                               //           title: Text('Update something'),
                      //                               //         ))
                      //                               //   });
                      //                               //   _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Profile updated successfully!')));
                      //                               // }
                      //                             }
                      //                         ),
                      //                       ),
                      //                       SizedBox(height: 10,),
                      //                       Padding(
                      //                           padding: EdgeInsets.only(top:20, bottom: 20, left: 20, right: 20),
                      //                           child: Column(
                      //                             children: <Widget>[
                      //                               TextField(
                      //                                 autofocus: true,
                      //                                 decoration: InputDecoration(
                      //                                   prefixIcon: Icon(Icons.attach_money_rounded, size: 20,),
                      //                                   labelText: 'Enter Amount',
                      //                                   hintText: 'Ex. 123.45',
                      //                                   errorText: isANumber ? null : "Please enter a number",
                      //                                 ),
                      //                                 keyboardType: TextInputType.number,
                      //                               ),
                      //                             ],
                      //                           )
                      //                       )
                      //                     ],
                      //                   ),
                      //                 )
                      //             );
                      //           }
                      //       );
                      //     },
                      //   ),
                      // )
                    ],
                  )
              ),),
              SizedBox(height: 20,),
              // Deposit FUNDS, P2P Transfer
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
                                        title: Text('Deposit Points', style: TextStyle(color: kThemeColor, fontSize: 20),),
                                        trailing: IconButton(
                                            icon: Icon(Icons.check, color: Colors.black,),
                                            iconSize: 25,
                                            onPressed: () {
                                              final snackBar = SnackBar(
                                                content: const Text('Points deposited successfully!'),
                                                duration: Duration(seconds: 2, milliseconds: 500),
                                              );
                                              loading ? Loading() : ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                            child: Icon(Icons.login_rounded, color: Colors.black,),
                          ),
                          SizedBox(height: 20,),
                          Text("Deposit Funds", style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
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
                                        title: Text('P2P Transfer', style: TextStyle(color: kThemeColor, fontSize: 20),),
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
                                              final snackBar = SnackBar(
                                                content: const Text('P2P transferred successfully!'),
                                                duration: Duration(seconds: 2, milliseconds: 500),
                                              );
                                              loading ? Loading() : ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                                                  prefixIcon: Icon(Icons.person, size: 20,),
                                                  labelText: 'Enter username of peer',
                                                  hintText: 'Ex. brego',
                                                ),
                                                keyboardType: TextInputType.text,
                                              ),
                                              SizedBox(height: 10,),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.attach_money_rounded, size: 20,),
                                                  labelText: 'Enter Amount to be transferred',
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
                            child: Icon(Icons.published_with_changes_rounded, color: Colors.black,),
                          ),
                          SizedBox(height: 20,),
                          Text("P2P Transfer", style: TextStyle(fontSize: 18),)
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
                                        title: Text('Withdraw Funds', style: TextStyle(color: kThemeColor, fontSize: 20),),
                                        trailing: IconButton(
                                            icon: Icon(Icons.check, color: Colors.black,),
                                            iconSize: 25,
                                            onPressed: () {
                                              final snackBar = SnackBar(
                                                content: const Text('Funds withdrawed successfully!'),
                                                duration: Duration(seconds: 2, milliseconds: 500),
                                              );
                                              loading ? Loading() : ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                                                  labelText: 'Enter Amount to be withdrawed',
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
                            child: Icon(Icons.monetization_on_rounded, color: Colors.black,),
                          ),
                          SizedBox(height: 20,),
                          Text("Withdraw Funds", style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
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
                                        title: Text('Transfer Funds', style: TextStyle(color: kThemeColor, fontSize: 20),),
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
            ],
          ),
        ),
      )
    );
  }
}
