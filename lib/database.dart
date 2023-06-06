import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:s_todo/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

var APPNAME = 'S-TODO';
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