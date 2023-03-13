import 'package:FinPay/DashboardPage.dart';
import 'package:FinPay/FadeAnimation.dart';
import 'package:FinPay/Loading.dart';
import 'package:FinPay/LoginPage.dart';
import 'package:FinPay/ThemeColor.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState>_registerFormKey = GlobalKey<FormState>();

  TextEditingController ufirstnameController = new TextEditingController();
  TextEditingController ulastnameController = new TextEditingController();
  TextEditingController uusernameController = new TextEditingController();
  TextEditingController upasswordController = new TextEditingController();
  TextEditingController uemailController = new TextEditingController();
  TextEditingController umobilenoController = new TextEditingController();

  bool loading = false;
  String? _errorMessage;

  @override
  void initState() {
    ufirstnameController = TextEditingController()..addListener(clearError);
    ulastnameController = TextEditingController()..addListener(clearError);
    uusernameController = TextEditingController()..addListener(clearError);
    upasswordController = TextEditingController()..addListener(clearError);
    uemailController = TextEditingController()..addListener(clearError);
    umobilenoController = TextEditingController()..addListener(clearError);
    super.initState();
  }

  @override
  void dispose() {
    ufirstnameController.dispose();
    ulastnameController.dispose();
    uusernameController.dispose();
    upasswordController.dispose();
    uemailController.dispose();
    umobilenoController.dispose();
    super.dispose();
  }

  void clearError() {
    if (_errorMessage != null) {
      setState(() {
        // Reset error message when user starts typing
        _errorMessage = null;
      });
    }
  }

  String emailValidator(String value) {
    // Pattern pattern =
    //     r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
    RegExp regex = new RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if (!regex.hasMatch(value) || value.isEmpty) {
      return 'Email format is invalid';
    } else {
      return "";
    }
  }

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
                          controller: ufirstnameController,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Enter First Name';
                            }
                            return null;
                          },
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
                          controller: ulastnameController,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Enter Last Name';
                            }
                            return null;
                          },
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
                          controller: uusernameController,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Enter User Name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Usermame',
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
                        ),),
                        SizedBox(height: 20.0,),
                        FadeAnimation(1.4, TextFormField(
                          controller: uemailController,
                          validator: (value) {
                            // Pattern pattern =
                            //     r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
                            // RegExp regex = new RegExp(pattern);
                            if (value!.isEmpty) {
                              return 'Email format is invalid';
                            } else {
                              return null;
                            };
                          },
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
                        FadeAnimation(1.6, TextFormField(
                          controller: umobilenoController,
                          // validator: (value) {
                          //   if (value.length < 6 || value.isEmpty) {
                          //     return 'Password must be longer than 6 characters';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          keyboardType: TextInputType.phone,
                          obscureText: true,
                          decoration: InputDecoration(
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
                                  onPressed: () {
                                    showDialog(context: context, builder: (BuildContext context) {
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
                SizedBox(height: 10.0,),
                Text(_errorMessage ?? "", style: TextStyle(color: Colors.red, fontSize: 14),),
                SizedBox(height: 30.0,),
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
}
