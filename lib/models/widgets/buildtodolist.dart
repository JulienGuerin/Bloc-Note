import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import '../../dbhelper.dart';
import '../../screens/edit_note.dart';
import '../../models/classes/notes.dart';

class BuildTodoList extends StatefulWidget {
  final int tabCounter;

  BuildTodoList(this.tabCounter);

  @override
  _BuildTodoListState createState() => _BuildTodoListState(this.tabCounter);
}

class _BuildTodoListState extends State<BuildTodoList>
    with SingleTickerProviderStateMixin {
  Databasehelper dbhelper = Databasehelper();
  List<Note> noteList;
  int count = 0;
  int tabCounter;

  int _pickIndex = 0;
  bool descTextShowFlag = false;
  ScrollController _hideButtonController;
  AnimationController _hideFabAnimController;
  var fabIsVisible;

  _BuildTodoListState(this.tabCounter);

  @override
  void initState() {
    super.initState();
    fabIsVisible = true;
    _hideButtonController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );
    _hideButtonController.addListener(() {
      switch (_hideButtonController.position.userScrollDirection) {
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  void dispose() {
    _hideButtonController.dispose();
    _hideFabAnimController.dispose();
    super.dispose();
  }

  void updateListView(int tabCounter) {
    final Future<Database> dbFuture = dbhelper.initDatabase();
    dbFuture.then((database) {
      switch (tabCounter) {
        case 1:
          Future<List<Note>> noteListFuture = dbhelper.getNoteList();
          noteListFuture.then((noteList) {
            setState(() {
              this.noteList = noteList;
              this.count = noteList.length;
            });
          });

          break;
        case 2:
          Future<List<Note>> noteListFuture = dbhelper.getNoteList1();
          noteListFuture.then((noteList) {
            setState(() {
              this.noteList = noteList;
              this.count = noteList.length;
            });
          });

          break;
        case 3:
          Future<List<Note>> noteListFuture = dbhelper.getNoteList2();
          noteListFuture.then((noteList) {
            setState(() {
              this.noteList = noteList;
              this.count = noteList.length;
            });
          });

          break;
        case 4:
          Future<List<Note>> noteListFuture = dbhelper.getNoteList3();
          noteListFuture.then((noteList) {
            setState(() {
              this.noteList = noteList;
              this.count = noteList.length;
            });
          });

          break;
        case 5:
          Future<List<Note>> noteListFuture = dbhelper.getNoteList4();
          noteListFuture.then((noteList) {
            setState(() {
              this.noteList = noteList;
              this.count = noteList.length;
            });
          });

          break;
      }
    });
  }

  void navigateToDetail(Note note, String title, int tabCounter) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NotePage(note, title, tabCounter);
    }));

    if (result == true) {
      updateListView(tabCounter);
    }
  }

  void _promptRemoveTodoItem(row, int index, int tabCounter) {
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
              contentTextStyle: TextStyle(
                color: Colors.white70,
                fontSize: 17,
              ),
              title: new Text(
                  'Veux-tu vraiment supprimer cette note de la liste ?'),
              content: Text("${this.noteList[index].title}"),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      'RETOUR',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text(
                      'SUPPRIMER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      // _removeTodoItem(index);
                      _delete(context, noteList[index], tabCounter);
                      setState(() {});
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _delete(BuildContext context, Note note, int tabCounter) async {
    switch (tabCounter) {
      case 1:
        int result = await dbhelper.deletedata(tableName[0], note.id);
        if (result != 0) {
          // _showSnackBar(context, 'Note Supprimé Avec Successé');
          updateListView(tabCounter);
        }
        break;
      case 2:
        int result = await dbhelper.deletedata(tableName[1], note.id);
        if (result != 0) {
          // _showSnackBar(context, 'Note Supprimé Avec Successé');
          updateListView(tabCounter);
        }
        break;
      case 3:
        int result = await dbhelper.deletedata(tableName[2], note.id);
        if (result != 0) {
          // _showSnackBar(context, 'Note Supprimé Avec Successé');
          updateListView(tabCounter);
        }
        break;
      case 4:
        int result = await dbhelper.deletedata(tableName[3], note.id);
        if (result != 0) {
          // _showSnackBar(context, 'Note Supprimé Avec Successé');
          updateListView(tabCounter);
        }
        break;
      case 5:
        int result = await dbhelper.deletedata(tableName[4], note.id);
        if (result != 0) {
          // _showSnackBar(context, 'Note Supprimé Avec Successé');
          updateListView(tabCounter);
        }
        break;
    }
  }

  // void _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }

  Widget _buildTodoItem(row, int index, int tabCounter) {
    return GestureDetector(
      onLongPress: () {
        _promptRemoveTodoItem(row, index, tabCounter);
      },
      onTap: () {
        navigateToDetail(this.noteList[index], 'Modifier la note', tabCounter);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        padding: EdgeInsets.only(left: 5, right: 10),
        //padding: EdgeInsets.only(left: 20,right: 20,top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.deepOrange[50],
          boxShadow: [
            new BoxShadow(
              color: Colors.black54,
              // offset: Offset(3, 2),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.62,
              child: ListTile(
                dense: true,
                title: Text(
                  this.noteList[index].title,
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: descTextShowFlag && _pickIndex == index ? null : 1,
                ),
                subtitle: Text(
                  this.noteList[index].date,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: descTextShowFlag && _pickIndex == index
                  ? Icon(
                      Icons.keyboard_arrow_up,
                      size: 35,
                      color: Colors.deepOrange,
                    )
                  : Icon(
                      Icons.keyboard_arrow_down,
                      size: 35,
                      color: Colors.deepOrange,
                    ),
              onPressed: () {
                setState(() {
                  _pickIndex = index;
                  descTextShowFlag = !descTextShowFlag;
                });
                //_promptRemoveTodoItem(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView(tabCounter);
    }
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(
            child: Text(
              "No Data",
            ),
          );
        } else {
          if (noteList.length == 0) {
            return Scaffold(
              floatingActionButton: new Visibility(
                visible: fabIsVisible,
                child: FloatingActionButton(
                  heroTag: Hero,
                  onPressed: () {
                    navigateToDetail(
                        Note('', ''), 'Ajouter une note', tabCounter);
                  }, // pressing this button now opens the new screen
                  tooltip: 'Add task',
                  child: new Icon(Icons.add),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Container(),
            );
          } else {
            return Scaffold(
              body: ListView.builder(
                padding: EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                controller: _hideButtonController,
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return _buildTodoItem(context, index, tabCounter);
                },
              ),
              floatingActionButton: FadeTransition(
                opacity: _hideFabAnimController,
                child: ScaleTransition(
                  scale: _hideFabAnimController,
                  child: FloatingActionButton(
                      heroTag: Hero,
                      onPressed: () {
                        navigateToDetail(
                            Note('', ''), 'Ajouter une note', tabCounter);
                      }, // pressing this button now opens the new screen
                      tooltip: 'Add task',
                      child: new Icon(Icons.add)),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        }
      },
    );
  }
}
