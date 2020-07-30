import 'package:flutter/material.dart';

import 'buildtodolist.dart';

class TacheTab extends StatefulWidget {
  @override
  _TacheTabState createState() => _TacheTabState();
}

class _TacheTabState extends State<TacheTab> 
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          bottom: PreferredSize(
            preferredSize: Size(0, 6),
            child: TabBar(
              // controller: _tabController,
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.white,
              indicatorWeight: 3.0,
              labelStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              tabs: <Widget>[
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Urgent',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Cette\nSemaine',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Ce\nMois-ci',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Cette\nAnnée',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BuildTodoList(2),
            BuildTodoList(3),
            BuildTodoList(4),
            BuildTodoList(5),
          ],
        ),
      ),
    );
  }
}
