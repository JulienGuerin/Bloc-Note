import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '../dbhelper.dart';
import '../models/classes/notes.dart';

class NotePage extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  final int tabCounter;

  NotePage(this.note, this.appBarTitle, this.tabCounter);

  @override
  _NotePageState createState() =>
      _NotePageState(this.note, this.appBarTitle, this.tabCounter);
}

class _NotePageState extends State<NotePage> {
  Databasehelper dbhelper = Databasehelper();

  String appBarTitle;
  Note note;
  final taskName = TextEditingController();
  int tabCounter;

  _NotePageState(this.note, this.appBarTitle, this.tabCounter);

  void _addTodoItem() async {
    Navigator.pop(context, true);
    note.date = DateFormat.yMd().format(DateTime.now());
    int result;

    switch (tabCounter) {
      case 1:
        if (note.id != null) {
          // Case 1: Update operation
          result = await dbhelper.update(tableName[0], note);
        } else {
          // Case 2: Insert Operation
          result = await dbhelper.insert(tableName[0], note);
        }
        break;
      case 2:
        if (note.id != null) {
          // Case 1: Update operation
          result = await dbhelper.update(tableName[1], note);
        } else {
          // Case 2: Insert Operation
          result = await dbhelper.insert(tableName[1], note);
        }
        break;
      case 3:
        if (note.id != null) {
          // Case 1: Update operation
          result = await dbhelper.update(tableName[2], note);
        } else {
          // Case 2: Insert Operation
          result = await dbhelper.insert(tableName[2], note);
        }
        break;
      case 4:
        if (note.id != null) {
          // Case 1: Update operation
          result = await dbhelper.update(tableName[3], note);
        } else {
          // Case 2: Insert Operation
          result = await dbhelper.insert(tableName[3], note);
        }
        break;
      case 5:
        if (note.id != null) {
          // Case 1: Update operation
          result = await dbhelper.update(tableName[4], note);
        } else {
          // Case 2: Insert Operation
          result = await dbhelper.insert(tableName[4], note);
        }
        break;
    }
    // if (result != 0) {  // Success
    // 	_showAlertDialog('Status', 'Note Saved Successfully');
    // } else {  // Failure
    // 	_showAlertDialog('Status', 'Problem Saving Note');
    // }
  }

  @override
  Widget build(BuildContext context) {
    taskName.text = note.title;

    return Scaffold(
      appBar: new AppBar(title: Text(appBarTitle)),
      body:
          // Ce qui suit pour enlever le focus du keyboard
          // GestureDetector(
          // onTap: () => FocusScope.of(context).unfocus(),
          new TextField(
        maxLines: 50,
        textCapitalization: TextCapitalization.sentences,
        controller: taskName,
        autofocus: true,
        onChanged: (_val) {
          updateTitle();
        },
        decoration: new InputDecoration(
          hintText: 'Ecrire quelque chose à faire...',
          contentPadding: const EdgeInsets.all(20.0),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        heroTag: 'btnote2',
        child: new Icon(Icons.add),
        onPressed: () {
          if (taskName.text.isEmpty) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return new AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      backgroundColor: Colors.green[400].withOpacity(0.9),
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      title: new Text(
                        'Impossible d\'ajouter une note vide !',
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 17,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop()),
                      ]);
                });
          } else {
            setState(() {
              _addTodoItem();
            });
          }
        },
      ),
    );
  }

  void updateTitle() {
    note.title = taskName.text;
  }
}
