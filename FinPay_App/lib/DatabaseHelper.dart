import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:FinPay/DashboardPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {

  String serverUrl = "https://8e3d-67-161-99-88.ngrok.io/api/users/register";

  bool status = true;
  var token = "";

  Future<void> storeUsernameAndPassword(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    // final String? action = prefs.getString('currentPage');
    // print(action);
  }

  loginData(String username, String password) async {
    String nameAndPassword = "$username:$password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final response = await http.post(Uri.parse('http://dronaji.in/api/users/login'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Basic ${stringToBase64.encode(nameAndPassword)}"
        },
        );

    print(response.body);
    if(response.statusCode == 200){
      print('Login successfully');
      storeUsernameAndPassword(username, password);
      status = true;
    }else {
      status = false;
      print('failed');
    }
  }

  register(String firstName, String lastName, String username, String email , String password, String mobile) async{
    final response = await http.post(Uri.parse('https://dronaji.in/api/users/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "user": {
            "firstName": firstName,
            "lastName": lastName,
            "username": username,
            "email": email,
            "password" : password,
            "mobile": mobile
          }
        })
    );

    print(response.body);
    // print(response.statusCode);


    if(response.statusCode == 200){

      print('Register successfully');
      storeUsernameAndPassword(username, password);
      status = true;
    }else {
      status = false;
      print('failed');
    }
  }

  List data = [];

  deposit(String Suser, String Tuser,int amount, String? username, String? password) async {
  print("From text field");
  print(amount);
    String nameAndPassword = "$username:$password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final response = await http.post(Uri.parse('http://dronaji.in/api/txn/exchange'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Basic ${stringToBase64.encode(nameAndPassword)}"
        },
        body: json.encode({
            "sourceUser" : Suser,
            "targetUser" : Suser,
            "currency" : "USD",
            "amount" : amount,
            "mode" : "deposit",
            "method": "default",
            "gateway" : "default",
            "description" : "description",
          }
        ));
    print("Deposit successful!");
    print(response.body);
    // print(responseData);
  }

  withdraw(String Suser, String Tuser, int amount, String? username, String? password) async {
    print("From text field");
    print(amount);
    String nameAndPassword = "$username:$password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final response = await http.post(Uri.parse('http://dronaji.in/api/txn/exchange'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Basic ${stringToBase64.encode(nameAndPassword)}"
        },
        body: json.encode({
          "sourceUser" : Suser,
          "targetUser" : Suser,
          "currency" : "USD",
          "amount" : amount,
          "mode" : "withdraw",
          "method": "default",
          "gateway" : "default",
          "description" : "description",
        }
        ));
    print("Withdraw successful!");
    print(response.body);
    // print(responseData);
  }

  p2p(String Suser, String Tuser, int amount, String? username, String? password) async {
    print("From text field");
    print(amount);
    String nameAndPassword = "$username:$password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final response = await http.post(Uri.parse('http://dronaji.in/api/txn/exchange'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Basic ${stringToBase64.encode(nameAndPassword)}"
        },
        body: json.encode({
          "sourceUser" : Suser,
          "targetUser" : Tuser,
          "currency" : "USD",
          "amount" : amount,
          "mode" : "p2p",
          "method": "default",
          "gateway" : "default",
          "description" : "description",
        }
        ));
    print("Transferred from $Suser to $Tuser");
    print(response.body);
    // print(responseData);
  }

  Future<Map<String, dynamic>> getUsers(String? username, String? password) async {

    String nameAndPassword = "$username:$password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    var response = await http.get(
      Uri.encodeFull("https://dronaji.in/api/users/getUsers"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Basic ${stringToBase64.encode(nameAndPassword)}"
      }
    );

    var responseData = json.decode(response.body);
    // print(responseData.runtimeType);
    // print(data[0]["email"]);
    return responseData;
  }

  save(String token) async {
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