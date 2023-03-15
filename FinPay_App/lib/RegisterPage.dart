import 'package:FinPay/DashboardPage.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:FinPay/Loading.dart';
import 'package:FinPay/LoginPage.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:FinPay/DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _ufirstnameController = new TextEditingController();
  final TextEditingController _ulastnameController = new TextEditingController();
  final TextEditingController _uusernameController = new TextEditingController();
  final TextEditingController _upasswordController = new TextEditingController();
  final TextEditingController _uemailController = new TextEditingController();
  final TextEditingController _umobilenoController = new TextEditingController();

  DatabaseHelper databaseHelper = new DatabaseHelper();
  bool loading = false;
  String msgStatus = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onPressed(){
    setState(() {
      if(_ufirstnameController.text.trim().isNotEmpty &&
          _ulastnameController.text.trim().isNotEmpty &&
          _uusernameController.text.trim().isNotEmpty &&
          _uemailController.text.trim().isNotEmpty &&
          _upasswordController.text.trim().isNotEmpty &&
          _umobilenoController.text.trim().isNotEmpty){
        databaseHelper.register(
            _ufirstnameController.text.trim(),
            _ulastnameController.text.trim(),
            _uusernameController.text.trim(),
            _uemailController.text.trim(),
            _upasswordController.text.trim(),
            _umobilenoController.text.trim())
            .whenComplete((){
          if(databaseHelper.status){
            print("DONE!!");
            _showAgreementDialog();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardPage()));

          }else{
            _showDialog();
            print(databaseHelper.status);
            msgStatus = 'Check username or password';
            print("error!!");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FadeAnimation(0.3,
                      Image.asset('assets/logo_white.png',
                        width: 90.0,
                        height: 90.0,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    FadeAnimation(0.4,
                      Text('Register with FlexPay',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 27.0,
                            color: kThemeColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    FadeAnimation(0.5,
                      Text('Create your account here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                  ],
                ),
                Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(0.6, TextFormField(
                          controller: _ufirstnameController,
                          // validator: (value) {
                          //   // if (value != null && value.isEmpty) {
                          //   //   return 'Enter First Name';
                          //   // }
                          //   return null;
                          // },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            icon: Icon(
                                Icons.person
                            ),
                            focusColor: Colors.black87,
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white70
                              ),
                            ),
                          ),
                        ),),
                        SizedBox(height: 20.0,),
                        FadeAnimation(0.8, TextFormField(
                          controller: _ulastnameController,
                          // validator: (value) {
                          //   // if (value != null && value.isEmpty) {
                          //   //   return 'Enter Last Name';
                          //   // }
                          //   return null;
                          // },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            icon: Icon(
                                Icons.person
                            ),
                            focusColor: Colors.black87,
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white70
                              ),
                            ),
                          ),
                        ),),
                        SizedBox(height: 20.0,),
                        FadeAnimation(1.0, TextFormField(
                          controller: _uusernameController,
                          // validator: (value) {
                          //   // if (value!.isEmpty && value.length > 8 && value.length < 8 && !value.contains("W")) {
                          //   // return 'Enter valid Student ID';
                          //   // }
                          //   return null;
                          // },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'SCU Student ID',
                            hintText: 'Ex. W1654769',
                            icon: Icon(
                                Icons.abc
                            ),
                            focusColor: Colors.black87,
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white70
                              ),
                            ),
                          ),
                        ),),
                        SizedBox(height: 20.0,),
                        FadeAnimation(1.2, TextFormField(
                          controller: _upasswordController,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Password must be longer than 10 characters';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            icon: Icon(
                                Icons.lock
                            ),
                            suffixIcon: Icon(
                                Icons.visibility
                            ),
                            focusColor: Colors.black87,
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white70
                              ),
                            ),
                          ),
                        ),),
                        SizedBox(height: 20.0,),
                        FadeAnimation(1.4, TextFormField(
                          controller: _uemailController,
                          // validator: (value) {
                          //   // if (value!.isEmpty && !value.contains('@scu.edu')) {
                          //   //   return 'Email format is invalid';
                          //   // } else {
                          //     return null;
                          //   // };
                          // },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: 'Ex. bbronco@scu.edu',
                            icon: Icon(Icons.email),
                            focusColor: Colors.black87,
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                          ),
                        ),),
                        SizedBox(height: 20.0,),
                        FadeAnimation(1.6, TextFormField(
                          controller: _umobilenoController,
                          // validator: (value) {
                          //   // if (value!.length < 10 || value.isEmpty) {
                          //   //   return 'mobile number must have 10 digits';
                          //   // } else {
                          //     return null;
                          //   // }
                          // },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Ex. 6697664555',
                            labelText: "Mobile Number",
                            icon: Icon(
                                Icons.phone
                            ),
                            focusColor: Colors.black87,
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white70
                              ),
                            ),
                          ),
                        ),),
                        SizedBox(height: 30.0,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: FadeAnimation(1.8,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: MaterialButton(
                                  minWidth: 180,
                                  height: 50,
                                  onPressed: _onPressed,
                                  color: kThemeColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text("Register",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  height: 20,
                  child: new Text(
                    '$msgStatus',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                  ),
                ),
                SizedBox(height: 20.0,),
                FadeAnimation(2.0,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?",
                          style: TextStyle(
                              fontSize: 16.0
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    )
                ),
                SizedBox(height: 50.0,),
              ],
            ),
          )
      ),
    );
  }

  void _showAgreementDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('TERMS OF SERVICE', style: TextStyle(color: kThemeColor, fontWeight: FontWeight.bold),),),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
              Text("PAYMENT", style: TextStyle(color: kThemeColor, fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text("All payments are due upon receipt. If a payment is not received or payment method is declined, he buyer forfeits the ownership of any item purchased. If no payment is received, request sender for payment."),
              SizedBox(height: 30,),
              Text("AUTHORIZED USERS", style: TextStyle(color: kThemeColor, fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text("All payments are due upon receipt. If a payment is not received or payment method is declined, he buyer forfeits the ownership of any item purchased. If no payment is received, request sender for payment."),
              SizedBox(height: 30,),
              Text("OTHER POLICIES", style: TextStyle(color: kThemeColor, fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text("All payments are due upon receipt. If a payment is not received or payment method is declined, he buyer forfeits the ownership of any item purchased. If no payment is received, request sender for payment."),
              SizedBox(height: 10,),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OutlinedButton(
                  child: Text('CANCEL', style: TextStyle(color: kThemeColor),),
                  style: OutlinedButton.styleFrom(
                    primary: kThemeColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
              OutlinedButton(
                  child: Text('ACCEPT', style: TextStyle(color: Colors.white),),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: kThemeColor,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) => DashboardPage())
                    );
                  }
              ),
            ],
          )
        ],
      );
    });
  }

  void _showDialog(){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Failed'),
            content:  new Text('Check your details'),
            actions: <Widget>[
              OutlinedButton(
                child: Text('Close',),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
}
