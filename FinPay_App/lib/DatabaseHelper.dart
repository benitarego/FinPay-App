import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:FinPay/DashboardPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {

  String serverUrl = "http://10.0.2.2:5000";

  var status;
  var token;

  loginData(String username, password) async {
    final response = await http.post('$serverUrl/loginUser',
        headers: {
          'Accept':'application/json'
        },
        body: json.encode({
          "username": "$username",
          "password" : "$password"
        }));
    status = response.body.contains('error');

    var data = json.decode(response.body);
    print(data);
    if(status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }

  }

  registerData(String firstname, String lastname, String username, String email , String password, String mobilenumber) async{
    final response = await http.post('$serverUrl/registerUser',
        headers: {
          'Accept':'application/json'
        },
        body: json.encode({
          "firstname": firstname,
          "lastname": lastname,
          "username": username,
          "email": email,
          "password" : password,
          "mobilenumber": mobilenumber
        })
    );

    status = response.body.contains('error');
    var data = json.decode(response.body);
    print(data);
    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  List data = [];

  Future<String> getUsers() async {
    var response = await http.get(
        Uri.encodeFull("$serverUrl/getUsers"),
        headers: {"Accept": "application/json"});

    data = json.decode(response.body);

    print(data[0]["email"]);
    return "success";
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }


  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }
}