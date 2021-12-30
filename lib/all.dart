import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myshop/sql_helper.dart';

import 'home_page.dart';
import 'model/product.dart';

class AllProudect extends StatefulWidget {
  AllProudect({Key key}) : super(key: key);

  @override
  _AllProudectState createState() => _AllProudectState();
}

class _AllProudectState extends State<AllProudect> {
  TextEditingController name = new TextEditingController();
  TextEditingController salary = new TextEditingController();
  TextEditingController proft = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController count = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Sql_Helper helper = new Sql_Helper();
  List<Product> items = new List();
  void initState() {
    super.initState();
    setState(() {
      helper.getProduct().then((product) {
        setState(() {
          product.forEach((product) {
            items.add(Product.getMap(product));
          });
        });
      });
    });
  }

  Future<int> Edit(int id, int kg, String name, String date, int salary,
      int proft, int count, BuildContext context) async {
    int f_salary = (salary + proft);
    final pro = Product.withId(id, name, salary, proft, f_salary, kg, count);
    var res = await helper.updateProduct(pro);
    if (res > 0) {
      helper.getProduct().then((product) {
        setState(() {
          product.forEach((product) {
            items.add(Product.getMap(product));
          });
        });
      });
      showbar(context, "Edited successfully", 1);
    } else {
      helper.getProduct().then((product) {
        setState(() {
          product.forEach((product) {
            items.add(Product.getMap(product));
          });
        });
      });
      showbar(context, "Somethings Wrong", 0);
    }
  }

  Future del(int id, String name, BuildContext context) async {
    var res = await helper.deleteProduct(id);
    var res2 = await helper.deleteSell(name);
    if (res > 0) {
      setState(() {
        helper.getProduct().then((product) {
          setState(() {
            product.forEach((product) {
              items.add(Product.getMap(product));
            });
          });
        });
        showbar(context, "Deleted successfully", 1);
      });
    } else {
      setState(() {
        helper.getProduct().then((product) {
          setState(() {
            product.forEach((product) {
              items.add(Product.getMap(product));
            });
          });
        });
        showbar(context, "Somethings Wrong", 0);
      });
    }
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
          appBar: AppBar(
            title: Text("All Product"),
            backgroundColor: Colors.deepPurple,
          ),
          body: Container(
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(bottom: 20),
              itemBuilder: (BuildContext context, int a) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Container(
                        width: 105,
                        child: Text("${items[a].name}"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: RaisedButton(
                          elevation: 10,
                          onPressed: () => edit(
                              items[a].id,
                              items[a].kg,
                              items[a].name,
                              items[a].salary,
                              items[a].count,
                              items[a].proft),
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: RaisedButton(
                          elevation: 10,
                          onPressed: () => show(items[a].name, items[a].salary,
                              items[a].count, items[a].proft),
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          child: Text("Veiw",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: IconButton(
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  del(items[a].id, items[a].name, context)))
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  show(String name, int salary, int count, int proft) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            title: Center(
                child: Text(
              "Product Ditels",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Item Name: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$name",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  children: <Widget>[
                    Text(
                      "Salary: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$salary",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  children: <Widget>[
                    Text(
                      "Count: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$count",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  children: <Widget>[
                    Text(
                      "Profit: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$proft",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
              ],
            ),
            actions: <Widget>[
              RaisedButton(
                elevation: 10,
                padding: EdgeInsets.all(3),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]);
      });

  edit(int id, int kg, String _name, int _salary, int _count, int _proft) {
    String name;
    int salary;
    int count;
    String date;
    int proft;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Edit"),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Name: $_name",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            name = _name;
                          } else
                            name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Salary: $_salary",
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            salary = _salary;
                          } else {
                            salary = int.tryParse(value);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Count: $_count",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            count = _count;
                          } else {
                            count = int.tryParse(value);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Proft: $_proft",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            proft = _proft;
                          } else {
                            proft = int.tryParse(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  color: Colors.deepPurple,
                  child: Text(
                    "Submitß",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        print(name);
                        print(salary);
                        print(date);
                        print(proft);
                        print(count);
                        Edit(id, kg, name, date, salary, proft, count, context);
                      });
                    }
                  },
                ),
                RaisedButton(
                  elevation: 10,
                  padding: EdgeInsets.all(3),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]);
        });
  }

  void showbar(BuildContext context, String msg, int ch) {
    var col;
    if (ch == 0) {
      col = Colors.red;
    } else {
      col = Colors.green;
    }
    var bar = SnackBar(
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: () {
          setState(() {});
        },
      ),
      backgroundColor: col,
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(bar);
  }
}
