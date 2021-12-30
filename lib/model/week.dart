class Week {
  int _id;
  String _item;
  int _itemProft;
  int _weekProft;

  Week(this._item, this._itemProft, this._weekProft);
  Week.withId(this._id, this._item, this._weekProft);

  int get id => _id;
  int get itemProft => _itemProft;
  int get weekProft => _weekProft;
  String get item => _item;

  set item(String value) {
    _item = value;
  }

  set itemProft(int value) {
    _itemProft = value;
  }

  set weekProft(int value) {
    _weekProft = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["item"] = this._item;
    map["weekProft"] = this._weekProft;
    return map;
  }

  Week.getMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._item = map["item"];
    this._weekProft = map["weekProft"];
  }
}
