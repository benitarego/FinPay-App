import 'package:FinPay/DashboardPage.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:FinPay/Loading.dart';
import 'package:FinPay/RegisterPage.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:FinPay/DatabaseHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState>_loginFormKey = GlobalKey<FormState>();
  TextEditingController uusernameController = new TextEditingController();
  TextEditingController upasswordController = new TextEditingController();

  bool loading = false;
  String? _errorMessage;

  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  @override
  void initState() {
    super.initState();
  }

  _onPressed() {
    setState(() {
      if(uusernameController.text.trim().isNotEmpty &&
          upasswordController.text.trim().isNotEmpty){
        databaseHelper.loginData(uusernameController.text.trim(),
            upasswordController.text.trim()).whenComplete((){
          if(databaseHelper.status){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardPage()));
          }else{
            _showDialog();
            msgStatus = 'Check email or password';
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
                      Text('Login',
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
                      Text('Login to your account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                  ],
                ),
                Form(
                  key: _loginFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(0.8, TextFormField(
                          controller: uusernameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username is empty';
                            } else {
                              return null;
                            };
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "SCU Student ID",
                            icon: Icon(Icons.person),
                            focusColor: Colors.black87,
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                          ),
                        ),),
                        SizedBox(height: 20.0,),
                        FadeAnimation(0.9, TextFormField(
                          controller: upasswordController,
                          validator: (value) {
                            if (value!.length < 10 || value.isEmpty) {
                              return 'Password must be longer than 10 characters';
                            } else {
                              return null;
                            }
                          },
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
                        ),
                        ),
                        SizedBox(height: 30.0,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: FadeAnimation(1.0,
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
                                  child: Text("Login",
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
                SizedBox(height: 10.0,),
                Container(
                  height: 20,
                  child: new Text(
                    '$msgStatus',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30.0,),
                FadeAnimation(1.1,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?",
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
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            "Register",
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
                SizedBox(height: 20.0,),
              ],
            ),
          )
      ),
    );
  }

  void _showDialog(){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Failed'),
            content:  new Text('Check your username or password'),
            actions: <Widget>[
              OutlinedButton(
                child: Text(
                  'Close',
                ),
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
