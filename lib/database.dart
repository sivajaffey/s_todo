import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s_todo/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

var APPNAME = 'S-TODO';
var APPESC = 'A TODO application';

NavigatePage(name, context) {
  if (name=='back') {
    Navigator.pop(context);
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (context) => name,));
  } 
}

getRandomID() {
  return DateTime.now().microsecondsSinceEpoch;
}

getSession() {
  final User? user = FirebaseAuth.instance.currentUser;
  return user;
}

ResetPassword(email,context) {
    FirebaseAuth.instance.sendPasswordResetEmail(
      email: email
    ).then((value) => {
            appAlert(context, 'Reset password link sent to email',(){}),
            NavigatePage(MyApp(),context)
      }, onError: (error)=>{
        appAlert(context, '${error.message}',(){})
      });
}

LoginUser(email,password, context) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      ).then((value) => {
            appAlert(context, 'Logged In',(){}),
            NavigatePage(MyApp(),context)
      }, onError: (error)=>{
        appAlert(context, '${error.message}',(){})
      });
}

LogoutUser() {
  FirebaseAuth.instance.signOut();
}

RegisterUser (email,password,context) {
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password
  ).then((value) => {
            appAlert(context, 'Registered',(){}),
            NavigatePage(MyApp(),context)
      }, onError: (error)=>{
        appAlert(context, '${error.message}',(){})
  });
}

addToList(title, desc, context, rows, id) {
  if (id == null) {
    int id=getRandomID();
      Map val = {
        'id': id,
        'title' : title,
        'desc' : desc,
        'checked' : 0,
        'pin':0,
        'remind':''
      };
      rows.add(val);
      saveData('${APPNAME}_row', rows);
      NavigatePage(MyApp(), context);
  } else {
    List arr = [];
    for(int i=0;i<rows.length;i++) {
      if (id.toString() == rows[i]['id'].toString()) {
        rows[i]['title'] = title;
        rows[i]['desc'] = desc;
        arr.add(rows[i]);
      } else {
        arr.add(rows[i]);
      }
    }
      saveData('${APPNAME}_row', arr);
      NavigatePage(MyApp(), context);
  }
}

saveData(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, jsonEncode(value));
}
rmData(key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}
loadData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}
appAlert(context, message, actionFunc) {
  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue[200],
            content: Text(message),
            action: SnackBarAction(
              label: 'Ok',
              textColor: Colors.white , 
              onPressed: () {
                actionFunc();
              },
            ),
          ),
        );
}