class Product {
  int _id;
  String _name;
  int _salary;
  int _proft;
  int _fsalary;
  int _kg;
  int _count;

  Product(this._name, this._salary, this._proft, this._fsalary, this._kg,
      this._count);
  Product.withId(this._id, this._name, this._salary, this._proft, this._fsalary,
      this._kg, this._count);

  int get id => _id;
  int get proft => _proft;
  int get salary => _salary;
  String get name => _name;

  int get fsalary => _fsalary;
  int get kg => _kg;
  int get count => _count;

  set name(String value) {
    _name = value;
  }

  set salary(int value) {
    _salary = value;
  }

  set proft(int value) {
    _proft = value;
  }

  set fsalary(int value) {
    _fsalary = value;
  }

  set kg(int value) {
    _kg = value;
  }

  set count(int value) {
    _count = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["name"] = this._name;
    map["salary"] = this._salary;
    map["proft"] = this._proft;

    map["fsalary"] = this._fsalary;
    map["kg"] = this._kg;
    map["count"] = this._count;
    return map;
  }

  Product.getMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._name = map["name"];
    this._salary = map["salary"];
    this._proft = map["proft"];

    this._fsalary = map["fsalary"];
    this._kg = map["kg"];
    this._count = map["count"];
  }
}
