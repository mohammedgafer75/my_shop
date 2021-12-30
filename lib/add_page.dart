import 'package:flutter/material.dart';
import 'package:myshop/sql_helper.dart';

import 'home_page.dart';
import 'model/product.dart';

class Add_page extends StatefulWidget {
  Add_page({Key key}) : super(key: key);

  @override
  _Add_pageState createState() => _Add_pageState();
}

class _Add_pageState extends State<Add_page> {
  MediaQueryData queryData;

  final _formKey = GlobalKey<FormState>();
  List<Product> items = new List();
  bool check = false;
  TextEditingController name = new TextEditingController();
  TextEditingController salary = new TextEditingController();
  TextEditingController proft = new TextEditingController();
  TextEditingController count = new TextEditingController();

  Sql_Helper helper = new Sql_Helper();
  var datenow = new DateTime.now();

  Future<int> Add(BuildContext context, bool ch) async {
    int kg;
    if (ch == false) {
      kg = 0;
    } else {
      kg = 1;
    }
    var _name = name.text;
    var _proft = proft.text;
    var _count = int.tryParse(count.text);

    var _salary = int.tryParse(salary.text);
    int p = int.tryParse(_proft);
    int _fsalary = _salary + p;

    final pro = Product(_name, _salary, p, _fsalary, kg, _count);
    var res = await helper.insertProduct(pro);

    if (res > 0) {
      show(context, "Added successfully", 1);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyHomePage();
          }));
        },
        child: Scaffold(
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text("Add Product"),
            ),
            body: Builder(
                builder: (context) => Form(
                      key: _formKey,
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              alignment: Alignment.center,
                              width: 300,
                              height: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: new Border.all(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: name,
                                      decoration: InputDecoration(
                                        hintText: "Product Name",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, left: 8.0, right: 8),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: count,
                                      decoration: InputDecoration(
                                          fillColor: Colors.deepPurple,
                                          hintText: "Product Count"),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(left: 165)),
                                      Text(
                                        "By:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 5)),
                                      Text("Kg"),
                                      Checkbox(
                                          value: check,
                                          activeColor: Colors.deepPurple,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              print(value);
                                              check = value;
                                            });
                                          }),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, left: 8.0, right: 8),
                                    child: TextFormField(
                                      controller: salary,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: "Product Salary"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: proft,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: "Product profit"),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: RaisedButton(
                                        color: Colors.deepPurple,
                                        child: Text(
                                          "Submitß",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            setState(() {
                                              Add(context, check);
                                            });
                                          }
                                        },
                                      )),
                                ],
                              ),
                            ),
                          )),
                    ))));
  }

  void show(BuildContext context, String msg, int ch) {
    var col;
    if (ch == 0) {
      col = Colors.red;
    } else {
      col = Colors.green;
    }
    var bar = SnackBar(
      backgroundColor: col,
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(bar);
  }
}
