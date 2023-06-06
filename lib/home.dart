import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:s_todo/add.dart';
import 'package:s_todo/database.dart';

import 'settings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List rows = [];
  void initState () {
    var val = loadData('${APPNAME}_row').then((data)=>{
      data = jsonDecode(data),
      if (data != null && data.length > 0) {
      for(int i=0;i<data.length;i++) {
         this.setState(() {
            if (data[i]['pin'] == 1){
              this.rows.insert(0, data[i]);
            } else {
              this.rows.add(data[i]);
            } 
        }),
      },
      } else {
        this.rows = []
      }
    });
  }
  AddToList() {
    NavigatePage(AddTodo(), context);
  }

  ViewRow(row) {
    saveData('_row', row['id']);
    NavigatePage(AddTodo(), context);
  }

  DeleteRow(row) {
    List arr = [];
    for(int i=0;i<this.rows.length;i++) {
      if (rows[i]['id'] != row['id']){
        arr.add(rows[i]);
      }
    }
    this.setState(() {
      this.rows = arr;
       saveData('${APPNAME}_row', this.rows);
    });
  }

  Pin(row) {
    for(int i=0;i<this.rows.length;i++) {
      if (rows[i]['id'] == row['id']){
        this.rows.remove(row);
        row['pin'] = (row['pin'] == 0) ? 1 : 0;
        this.rows.insert(0, row);
      }
    }
    this.setState(() {
      this.rows = rows;
       saveData('${APPNAME}_row', this.rows);
    });
    this.rows.sort((a, b) => b['pin'] < 1);
  }

  Done(row) {
    for(int i=0;i<this.rows.length;i++) {
      if (this.rows[i]['id'] == row['id']){
        row['checked'] = (row['checked'] == 0) ? 1 : 0;
      }
    }
    this.setState(() {
      this.rows = this.rows;
       saveData('${APPNAME}_row', this.rows);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APPNAME, style: TextStyle(color: Colors.blue[900]),),
        actions : [
          TextButton(onPressed: ()=>{
            NavigatePage(SettingsContent(), context),
          }, child: Icon(Icons.settings))
        ]
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            for(int i=0;i<this.rows.length;i++)
            ListTile(onTap:()=>ViewRow(this.rows[i]), title: Text(this.rows[i]['title'].toString(), style: TextStyle(decorationColor : (this.rows[i]['checked'] == 1 ) ? Colors.red : Colors.black , decoration: (this.rows[i]['checked'] == 1 ) ? TextDecoration.lineThrough : TextDecoration.none),), trailing: Wrap(
              children: [
                TextButton(onPressed: () => Pin(this.rows[i]), child: (this.rows[i]['pin'] == 1) ? Icon(Icons.push_pin_outlined, color: Colors.red[900],) : Icon(Icons.push_pin_outlined, color: Colors.blueGrey[200],)),
                TextButton(onPressed: () => ViewRow(this.rows[i]), child: Icon(Icons.remove_red_eye_outlined, color: Colors.blue[900],)),
                TextButton(onPressed: () => DeleteRow(this.rows[i]), child: Icon(Icons.delete, color: Colors.blue[900])),
              ],
            ), leading: TextButton(child: (this.rows[i]['checked'] == 1 ) ? Icon(Icons.check_box,color: Colors.red[900],) : Icon(Icons.check_box_outline_blank,color: Colors.blue[900],), 
            onPressed:()=>Done(this.rows[i]),) ,
            // subtitle: Text(this.rows[i]['desc'].toString(), style: TextStyle(decorationColor : (this.rows[i]['checked'] == 1 ) ? Colors.red : Colors.black , decoration: (this.rows[i]['checked'] == 1 ) ? TextDecoration.lineThrough : TextDecoration.none)),
            hoverColor : Colors.blue[50]),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: AddToList,
        tooltip: ' Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
