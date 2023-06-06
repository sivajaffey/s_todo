import 'dart:convert';

import 'package:flutter/material.dart';
import 'database.dart';


class AddTodo extends StatefulWidget {
  const AddTodo({super.key, data});
 
  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  var title = '';
  var desc = '';
  @override
  
  List rows = [];
  var id = null;
  
  void initState () {
    var ID = null;
    loadData('_row').then((id)=>{
      ID = id,
      rmData('_row'),
    });
    loadData('${APPNAME}_row').then((data)=>{
      data = jsonDecode(data),
      if (data != null && data.length > 0) {
      for(int i=0;i<data.length;i++) {
        if ((ID != null) && (ID.toString() == data[i]['id'].toString())) {
          this.setState(() {
            this.id = ID;
            this._title.text = data[i]['title'];
            this._desc.text = data[i]['desc'];
            this.title = data[i]['title'];
            this.desc = data[i]['desc'];
          }),
        },
        this.setState(() {
          this.rows.add(data[i]);
        }),
      },
      } else {
        this.rows = []
      }
    });
    
  }
  
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed: ()=>{
          NavigatePage('back', context),
        }, child: Icon(Icons.arrow_back)),
        ),
        body: Padding(padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  TextField(
                    controller: _title,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      prefixIcon: Icon(Icons.title, color: Colors.blue,)
                    ),
                    onChanged: (value) => setState((){this.title = value; })
                  ),
                  SizedBox(height: 26.0,),
                  TextField(
                    controller: _desc,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      prefixIcon: Icon(Icons.description, color: Colors.blue,)
                    ),
                    onChanged: (value) => setState((){this.desc = value; })
                  ),
                  
              ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (this.title.trim() != '' && this.title.trim() != '')
          addToList(this.title.trim(), this.desc.trim(), context, this.rows,this.id);
        },
        tooltip: 'Add to List',
        child: Icon(Icons.send),
      ), 
    );
  }
}