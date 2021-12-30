class Month {
  int _id;
  String _item;
  int _itemProft;
  int _monthProft;

  Month(this._item, this._itemProft, this._monthProft);
  Month.withId(this._id, this._itemProft, this._item, this._monthProft);

  int get id => _id;
  int get itemProft => _itemProft;
  int get monthProft => _monthProft;
  String get item => _item;

  set item(String value) {
    _item = value;
  }

  set itemProft(int value) {
    _itemProft = value;
  }

  set monthProft(int value) {
    _monthProft = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["item"] = this._item;
    map["itemProft"] = this._itemProft;
    map["monthProft"] = this._monthProft;
    return map;
  }

  Month.getMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._item = map["item"];
    this._itemProft = map["itemProft"];
    this._monthProft = map["monthProft"];
  }
}
