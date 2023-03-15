import 'package:FinPay/DashboardPage.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:FinPay/Loading.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:FinPay/LoginPage.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool loading = false;

  bool isANumber = true;

  TextEditingController ufirstnameController = new TextEditingController();
  TextEditingController ulastnameController = new TextEditingController();
  TextEditingController uusernameController = new TextEditingController();
  TextEditingController upasswordController = new TextEditingController();
  TextEditingController uemailController = new TextEditingController();
  TextEditingController umobilenoController = new TextEditingController();

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
        title: Center(child: Text('Profile', style: TextStyle(color: kThemeColor),),),
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
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10,),
                ProfileCard(),
                SizedBox(height: 20,),
                Divider(height: 10,),
                SizedBox(height: 20,),
                //EDIT Profile
                FadeAnimation(1.4, GestureDetector(
                  onTap: () {
                    showBottomSheet(
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
                                            ufirstnameController.clear(); ulastnameController.clear(); uusernameController.clear();
                                            upasswordController.clear(); uemailController.clear(); umobilenoController.clear();
                                          }
                                      ),
                                      title: Text('Edit Profile', style: TextStyle(color: kThemeColor, fontSize: 20),),
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
                                              content: const Text('Updated successfully!'),
                                              duration: Duration(seconds: 2, milliseconds: 500),
                                            );
                                            loading ? Loading() : ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    CircleAvatar(
                                      maxRadius: 40,
                                      backgroundColor: Colors.black,
//                                              backgroundImage: AssetImage('asset/user.png'),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                        padding: EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20),
                                        child: Column(
                                          children: <Widget>[
                                            TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(labelText: 'First Name', hintText: 'Will be displayed in profile'),
                                              keyboardType: TextInputType.text,
                                              controller: ufirstnameController,
                                            ),
                                            SizedBox(width: 5,),
                                            TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(labelText: 'Last Name', hintText: 'Will be displayed in profile'),
                                              keyboardType: TextInputType.text,
                                              controller: ulastnameController,
                                            ),
                                            TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(labelText: 'Username', hintText: 'Ex. @jackdoe'),
                                              keyboardType: TextInputType.text,
                                              controller: uusernameController,
                                            ),
                                            TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(labelText: 'Email'),
                                              keyboardType: TextInputType.emailAddress,
                                              controller: uemailController,
                                            ),
                                            TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(labelText: 'Mobile Number', hintText: 'Ex. +91 9897656734'),
                                              keyboardType: TextInputType.phone,
                                              controller: umobilenoController,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.edit_rounded, color: Colors.black54, size: 20,),
                          SizedBox(width: 20.0,),
                          Text('Edit Profile', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black54),),
                          SizedBox(width: 5.0,),
                        ],
                      )
                  ),
                ),),
                SizedBox(height: 20,),
                //MFA Authentication - Enable, Verify, Delete 2FA
                FadeAnimation(1.6, GestureDetector(
                  onTap: () {
                    showBottomSheet(
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
                                          }
                                      ),
                                      title: Text('MFA Authentication', textAlign: TextAlign.center, style: TextStyle(color: kThemeColor, fontSize: 20),),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                        padding: EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20),
                                        child: Column(
                                          children: <Widget>[
                                            // Enable 2FA
                                            FloatingActionButton.extended(
                                              backgroundColor: Colors.black,
                                              onPressed: () {
                                                showDialog(
                                                  context: context, barrierDismissible: false, // user must tap button!
                                                  builder: (BuildContext context) {
                                                    return new AlertDialog(
                                                      title: new Text('Enable 2FA'),
                                                      content: new SingleChildScrollView(
                                                        child: new ListBody(
                                                          children: [
                                                            TextField(
                                                              autofocus: true,
                                                              decoration: InputDecoration(
                                                                prefixIcon: Icon(Icons.attach_money_rounded, size: 20,),
                                                                labelText: 'Enter 6-Digit Passcode',
                                                                hintText: 'Ex. 123456',
                                                                errorText: isANumber ? null : "Please enter a number",
                                                              ),
                                                              keyboardType: TextInputType.number,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          child: Text('Cancel'),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text('Ok'),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            final snackBar = SnackBar(
                                                              content: const Text('Enabled 2FA successfully!'),
                                                              duration: Duration(seconds: 2, milliseconds: 500),
                                                            );
                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon( // <-- Icon
                                                Icons.verified_user_outlined,
                                                size: 24.0,
                                              ),
                                              label: Text('Enable 2FA'), // <-- Text
                                            ),
                                            SizedBox(height: 20,),
                                            // Verify 2FA
                                            FloatingActionButton.extended(
                                              backgroundColor: Colors.black,
                                              onPressed: () {

                                                final snackBar = SnackBar(
                                                  content: const Text('2FA verified successfully!'),
                                                  duration: Duration(seconds: 2, milliseconds: 500),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              },
                                              icon: Icon(
                                                Icons.verified_user_rounded,
                                                size: 24.0,
                                              ),
                                              label: Text('Verify 2FA'),
                                            ),
                                            SizedBox(height: 20,),
                                            // Delete 2FA
                                            FloatingActionButton.extended(
                                              backgroundColor: Colors.black,
                                              onPressed: () {

                                                final snackBar = SnackBar(
                                                  content: const Text('2FA deleted successfully!'),
                                                  duration: Duration(seconds: 2, milliseconds: 500),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              },
                                              icon: Icon( // <-- Icon
                                                Icons.cancel_outlined,
                                                size: 24.0,
                                              ),
                                              label: Text('Delete 2FA'), // <-- Text
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
                      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.shield, color: Colors.black54, size: 20,),
                          SizedBox(width: 20,),
                          Text("MFA Authentication",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 16
                            ),
                          ),
                        ],
                      )
                  ),
                )),
                SizedBox(height: 20,),
                FadeAnimation(2.0, GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) => LoginPage())
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.logout, color: Colors.black54, size: 20,),
                          SizedBox(width: 20,),
                          Text("Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 16
                            ),
                          ),
                        ],
                      )
                  ),
                )),

              ],
            ),
          )
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({
    @required this.ufirstname,
    this.ulastname,
    this.uusername,
    this.uemail,
    this.umobilenumber,
    this.uimg
  });

  final ufirstname;
  final ulastname;
  final uusername;
  final uemail;
  final umobilenumber;
  final uimg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          FadeAnimation(0.3, CircleAvatar(
            backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
            maxRadius: 50,
          ),),
          SizedBox(height: 20,),
          FadeAnimation(0.4, Text("Jack Doe", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 28.0),),),
          SizedBox(height: 10,),
          FadeAnimation(0.6, Text("@jackdoe", style: TextStyle(color: kThemeColor, fontWeight: FontWeight.w300, fontSize: 17.0),),),
          SizedBox(height: 15,),
          FadeAnimation(0.8, Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.email, size: 20.0, color: Colors.black,),
              SizedBox(width: 10.0,),
              Text("jackdoe@test.com", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18.0),)
            ],
          ),),
          SizedBox(height: 15,),
          FadeAnimation(1.0, Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.phone, size: 20.0, color: Colors.black,),
              SizedBox(width: 10.0,),
              Text("+91 9988776655", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18.0),)
            ],
          ),),
          SizedBox(height: 15,),
          FadeAnimation(1.2, Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Currency: ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18.0),),
              SizedBox(width: 5.0,),
              Text("INR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0),)
            ],),
          ),
        ],
      ),
    );
  }
}
