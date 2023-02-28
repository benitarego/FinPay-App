import 'package:FinPay/Loading.dart';
import 'package:flutter/material.dart';

class MFACreationPage extends StatefulWidget {
  const MFACreationPage({Key? key}) : super(key: key);

  @override
  State<MFACreationPage> createState() => _MFACreationPageState();
}

class _MFACreationPageState extends State<MFACreationPage> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Center(
      child: Text("MFA Creation Page"),
    );
  }
}
