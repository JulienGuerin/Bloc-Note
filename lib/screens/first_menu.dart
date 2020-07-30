import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:blocnote/models/classes/constants.dart';
import '../models/widgets/buildtodolist.dart';
import '../models/widgets/tache_tab.dart';

class FirstMenu extends StatefulWidget {
  @override
  _FirstMenuState createState() => _FirstMenuState();
}

class _FirstMenuState extends State<FirstMenu> {
  ChoixMenu _selectedChoice = choices[0];

  void _select(ChoixMenu choice) {
    setState(() {
      _selectedChoice = choice;
    });
    if (choice == choices[0]) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                backgroundColor: Colors.green[400].withOpacity(0.9),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                contentTextStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
                title: Text(
                  'Version 1.0',
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    'Merci d\'avoir téléchargé cette application.\n\nIl s\'agit d\'un bloc note standard dans lequel vous avez également la possibilité d\'enregistrer vos tâches, envies ou projets à réaliser, en fonction de leurs échéances.\n\nA noter que nous n\'analysons pas vos données, et que nous n\'y avons aucun accès. Elles s\'enregistrent automatiquement dans la mémoire de votre appareil.\n\nEn espérant répondre à vos attentes, bonne utilisation !',
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop()),
                ]);
          });
    } else if (choice == choices[1]) {
      share(context);
    }
  }

  void share(BuildContext context) {
    Share.share(
        'Je te conseil cette appli Bloc Note ! Elle est pratique et tes données ne sont pas analysées.\nhttps://play.google.com/store/apps/details?id=com.hooptech.blocnote&hl=fr');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bloc Note',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(
                Icons.more_horiz,
                size: 30.0,
              ),
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((ChoixMenu choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: new ListTile(
                      //leading: choice.icon,
                      title: choice.title,
                      trailing: choice.icon,
                      selected: true,
                    ),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(
            // isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.deepOrange,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                child: Container(
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'A Faire',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BuildTodoList(1),
            TacheTab(),
          ],
        ),
      ),
    );
  }
}
