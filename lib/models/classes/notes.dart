class Note {
  int _id;
  String _title;
  String _date;

  Note(this._title, this._date);

  Note.withId(this._id, this._title, this._date);

  int get id => _id;

  String get title => _title;

  String get date => _date;

  set title(String newTitle) {
    this._title = newTitle;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._date = map['date'];
  }
}

List<String> tableName = <String>[
  'mytable',
  'mytable1',
  'mytable2',
  'mytable3',
  'mytable4',
];
