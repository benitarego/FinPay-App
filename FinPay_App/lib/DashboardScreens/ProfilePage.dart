import 'package:FinPay/DashboardPage.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:FinPay/Loading.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Profile Page", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: kThemeColor,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40,),
                ProfileCard(),
                SizedBox(height: 40,),
                FadeAnimation(1.4, GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) => ProfileEdit())
                    );
                  },
                  child: Container(
                      height: 40,
                      width: 150,
                      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: kThemeColor
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.edit, color: Colors.white, size: 18,),
                          SizedBox(width: 10,),
                          Text("Edit Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ],
                      )
                  ),
                )),
                SizedBox(height: 20,),
                FadeAnimation(1.6, GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) => DashboardPage())
                    );
                  },
                  child: Container(
                      height: 40,
                      width: 200,
                      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.red
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.delete_forever, color: Colors.white, size: 22,),
                          SizedBox(width: 10,),
                          Text("Delete Account",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18
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
          FadeAnimation(0.4, Text("Jack Doe", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0),),),
          SizedBox(height: 10,),
          FadeAnimation(0.6, Text("@jackdoe", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 18.0),),),
          SizedBox(height: 15,),
          FadeAnimation(0.8, Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.email, size: 22.0, color: Colors.black,),
              SizedBox(width: 10.0,),
              Text("jackdoe@test.com", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20.0),)
            ],
          ),),
          SizedBox(height: 15,),
          FadeAnimation(1.0, Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.phone, size: 22.0, color: Colors.black,),
              SizedBox(width: 10.0,),
              Text("+91 9988776655", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20.0),)
            ],
          ),),
          SizedBox(height: 15,),
          FadeAnimation(1.2, Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Currency: ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20.0),),
              SizedBox(width: 5.0,),
              Text("INR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0),)
            ],),
          ),
        ],
      ),
    );
  }
}
