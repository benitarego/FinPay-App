import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:FinPay/DashboardPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {

  String serverUrl = "https://8e3d-67-161-99-88.ngrok.io/api/users/register";

  var status;
  var token;

  loginData(String username, password) async {
    final response = await http.post('$serverUrl/login',
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

  register(String firstname, String lastname, String username, String email , String password, String mobilenumber) async{

    final response = await http.post(Uri.parse('https://8e3d-67-161-99-88.ngrok.io/api/users/register'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: {
          "user": json.encode({
            "firstName": firstname,
            "lastName": lastname,
            "username": username,
            "email": email,
            "password" : password,
            "mobile": mobilenumber
          })
        }
    );

    print(response.body);
    print(response.statusCode);

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      print(data['token']);
      print('Register successfully');

    }else {
      print('failed');
    }

    // if(status){
    //   print('data: ${data["error"]}');
    // }else{
    //   print('data: ${data["token"]}');
    //   _save(data["token"]);
    // }
  }

  List data = [];

  Future<String> getUsers() async {
    var response = await http.get(
      Uri.encodeFull("$serverUrl/getUsers"),
      headers: {
        "Accept": "application/json"
      }
    );

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