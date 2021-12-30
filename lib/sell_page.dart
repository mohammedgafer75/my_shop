import 'package:flutter/material.dart';
import 'package:myshop/home_page.dart';
import 'package:myshop/model/product.dart';
import 'package:myshop/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/sells.dart';

class SellPage extends StatefulWidget {
  SellPage({Key key}) : super(key: key);

  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  void initState() {
    super.initState();
    checkState();
    setState(() {
      helper.getProduct().then((product) {
        setState(() {
          product.forEach((product) {
            items.add(Product.getMap(product));
          });
        });
      });
    });
    helper.getSells().then((sells) {
      setState(() {
        sells.forEach((sells) {
          items2.add(Sells.getMap(sells));
        });
      });
    });
  }

  Sql_Helper helper = new Sql_Helper();
  List<Sells> items2 = new List();
  List<Product> items = new List();
  String name;
  int salary;
  var datenow = new DateTime.now();

  TextEditingController count = new TextEditingController();

  String kgn = "";
  int kg;
  int proft;
  int id;
  int fsalary;
  int o_count;

  checkState() async {
    sharedpreference = await SharedPreferences.getInstance();
    name = sharedpreference.getString("name");
    salary = int.tryParse(sharedpreference.getString("salary"));
    id = int.tryParse(sharedpreference.getString("id"));
    kg = int.tryParse(sharedpreference.getString("kg"));
    proft = int.tryParse(sharedpreference.getString("proft"));
    fsalary = int.tryParse(sharedpreference.getString("fsalary"));
    o_count = int.tryParse(sharedpreference.getString("count"));
    if (kg == 1) {
      kgn = "by kg";
    }
  }

  Future<int> Sell(BuildContext context, int n_count) async {
    int a = 0;
    if (n_count > o_count) {
      showbar(context, "you don't have enough count", 0);
    } else {
      items2.forEach((i) {
        if (i.itemName == name) {
          a = 1;
        }
      });

      String month = datenow.month.toString();

      if (a == 0) {
      var _proft = proft * n_count;
        var sell = Sells(name, month, _proft, n_count, kg);
        var res = await helper.sell(sell);
        var _count = o_count - n_count;
        
        var pro = Product.withId(id, name, salary, proft, fsalary, kg, _count);
        var res2 = await helper.updateProduct(pro);

        if (res > 0 && res2 > 0) {
          showbar(context, "Item Sell successfully", 1);
        } else {
          showbar(context, "SomeThings wrong", 0);
        }
        return res;
      } else {
        items2.forEach((i) async {
          if (i.itemName == name) {
            var _proft = proft * n_count;
            int old_proft = i.proft;
            int new_proft = old_proft + _proft;
            int old_count = i.count;
            int last_count = old_count + n_count;
            int id = i.id;
            var sell = Sells.withId(id, name, month, new_proft, last_count, kg);
            var res = await helper.updateSells(sell);
            var _count = o_count - n_count;
            var pro =
                Product.withId(id, name, salary, proft, fsalary, kg, _count);
            var res2 = await helper.updateProduct(pro);

            if (res > 0 && res2 > 0) {
              showbar(context, "Item Sell successfully", 1);
            } else {
              showbar(context, "SomeThings wrong", 0);
            }
          }
        });
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  SharedPreferences sharedpreference;
  @override
  Widget build(BuildContext context) {
    int count1;
    return Container(
        child: WillPopScope(
            onWillPop: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return MyHomePage();
              }));
            },
            child: Scaffold(
                backgroundColor: Colors.deepPurple,
                appBar: AppBar(
                  backgroundColor: Colors.deepPurple,
                  title: Text("Sell"),
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
                                      Center(
                                        child: Text(
                                          "$name",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 20)),
                                      Center(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Salary: ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "$fsalary",
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: count,
                                          decoration: InputDecoration(
                                              hintText: "Count: $kgn",
                                              hintStyle: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          // ignore: missing_return
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "please enter how much you want to sell";
                                            } else {
                                              count1 = int.tryParse(value);
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: RaisedButton(
                                            color: Colors.deepPurple,
                                            child: Text(
                                              "Submitß",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      18.0),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                setState(() {
                                                  Sell(context, count1);
                                                });
                                              }
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                              )),
                        )))));
  }

  void showbar(BuildContext context, String msg, int ch) {
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
