import 'package:finpay_app/DashboardPage.dart';
import 'package:finpay_app/FadeAnimation.dart';
import 'package:finpay_app/Loading.dart';
import 'package:finpay_app/LoginPage.dart';
import 'package:finpay_app/ThemeColor.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState>_registerFormKey = GlobalKey<FormState>();
  TextEditingController ufullnameController = new TextEditingController();
  TextEditingController uemailController = new TextEditingController();
  TextEditingController upasswordController = new TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  // String emailValidator(String value) {
  //   Pattern pattern =
  //       r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value)) {
  //     return 'Email format is invalid';
  //   } else {
  //     return null;
  //   }
  // }

  // void register() {
  //   if (_registerFormKey.currentState.validate()) {
  //     setState(() => loading = true);
  //     Navigator.pushAndRemoveUntil(
  //         context, MaterialPageRoute(
  //         builder: (context) => DashboardPage()));
  //     // FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     //     email: uemailController.text.trim(),
  //     //     password: upasswordController.text)
  //     //     .then((currentUser) => Firestore.instance
  //     //     .collection("Users")
  //     //     .document(currentUser.user.uid)
  //     //     .setData({
  //     //   // "uid": currentUser.user.uid,
  //     //   "fullname": ufullnameController.text,
  //     //   "uemail": uemailController.text,
  //     //   "upassword": upasswordController.text
  //     // }).then((result) => {
  //     //   Navigator.pushAndRemoveUntil(
  //     //       context, MaterialPageRoute(
  //     //       builder: (context) => DashboardScreen(uid: currentUser.user.uid)), (_) => false),
  //     //   ufullnameController.clear(),
  //     //   uemailController.clear(),
  //     //   upasswordController.clear()
  //     // })
  //     //     .catchError((e) => print(e)))
  //     //     .catchError((e) => print(e));
  //     print("registered");
  //     // } else {
  //     //   setState(() {
  //     //     error = 'Please check the details entered';
  //     //     loading = false;
  //     //   });
  //     // }
  //   }
  // }

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
                      Text('Register with FinPay',
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
                  key: _registerFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(0.6, TextFormField(
                          controller: ufullnameController,
                          // validator: (value) {
                          //   if (value.length < 3 || value.isEmpty) {
                          //     return 'Enter Full Name';
                          //   }
                          //   return null;
                          // },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
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
                          controller: uemailController,
                          // validator: emailValidator,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            icon: Icon(Icons.email),
                            focusColor: Colors.black87,
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white70),),
                          ),
                        ),),
                        SizedBox(height: 20.0,),
                        FadeAnimation(0.9, TextFormField(
                          controller: upasswordController,
                          // validator: (value) {
                          //   if (value.length < 6 || value.isEmpty) {
                          //     return 'Password must be longer than 6 characters';
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
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) => DashboardPage())
                                    );
                                  },
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
                // SizedBox(height: 10.0,),
                // Text(error, style: TextStyle(color: Colors.red, fontSize: 14),),
                SizedBox(height: 30.0,),
                FadeAnimation(1.1,
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
                SizedBox(height: 20.0,),
              ],
            ),
          )
      ),
    );
  }
}
