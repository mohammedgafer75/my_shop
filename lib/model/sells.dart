class Sells {
  int _id;
  String _itemName;
  String _date;
  int _proft;
  int _count;
  int _kg;

  Sells(this._itemName, this._date, this._proft, this._count, this._kg);
  Sells.withId(
      this._id, this._itemName, this._date, this._proft, this._count, this._kg);

  int get id => _id;
  int get proft => _proft;
  String get itemName => _itemName;
  String get date => _date;
  int get count => _count;
  int get kg => _kg;

  set itemName(String value) {
    _itemName = value;
  }

  set date(String value) {
    _date = value;
  }

  set proft(int value) {
    _proft = value;
  }

  set count(int value) {
    _count = value;
  }

  set kg(int value) {
    _kg = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["name"] = this._itemName;
    map["proft"] = this._proft;
    map["date"] = this._date;
    map["count"] = this._count;
    map["kg"] = this._kg;
    return map;
  }

  Sells.getMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._itemName = map["name"];
    this._proft = map["proft"];
    this._date = map["date"];
    this._count = map["count"];
    this._kg = map["kg"];
  }
}
