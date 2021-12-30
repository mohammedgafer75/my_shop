import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshop/add_page.dart';
import 'package:myshop/all.dart';
import 'package:myshop/model/product.dart';
import 'package:myshop/model/sells.dart';
import 'package:myshop/month.dart';
import 'package:myshop/sell_page.dart';
import 'package:myshop/sql_helper.dart';
import 'package:myshop/week.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> items = new List();
  List<Sells> items2 = new List();

  bool check = false;
  int kg;
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
    setState(() {
      helper.getSells().then((sells) {
        setState(() {
          sells.forEach((sells) {
            items2.add(Sells.getMap(sells));
          });
        });
      });
    });
  }

  ch(int a) {
    if (a == 0) {
      return "";
    }
    if (a == 1) {
      return "kg";
    }
  }

  TextEditingController name = new TextEditingController();
  TextEditingController salary = new TextEditingController();
  TextEditingController proft = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController count = new TextEditingController();
  var datenow = new DateTime.now();

  Sql_Helper helper = new Sql_Helper();

  Future<int> add() async {
    if (check = false) {
      kg = 0;
    } else {
      kg = 1;
    }
    var _name = name.text;
    var _date = date.text;
    var _proft = proft.text;
    var _salary = int.tryParse(salary.text);
    int p = int.tryParse(_proft);
    int f_salary = _salary + p;
    final pro = Product(_name, _salary, p, f_salary, 2, kg);
    var res = await helper.insertProduct(pro);

    return res;
  }

  // ignore: missing_return
  Future<int> del(BuildContext context) async {
    var res = await helper.delete();
    if (res > 0) {
      showbar(context, "All data deleted", 1);
    } else {
      showbar(context, "somthings wrong", 0);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Add_page();
                }),
              );
            }
          },
          color: Colors.deepPurple,
          backgroundColor: Colors.white70,
          height: 40,
          items: <Widget>[
            Center(
                child: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ))
          ]),
      appBar: AppBar(
        title: Text("MyShop"),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: _drawer,
      body: Stack(children: <Widget>[dashBg, content]),
    );
  }

  get _drawer => Drawer(
      elevation: 14,
      child: Container(
        width: 40,
        color: Colors.deepPurple[50],
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Stack(children: <Widget>[
                  Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.deepPurple[50],
                        child: Icon(Icons.shopping_cart,
                            size: 60, color: Colors.deepPurple),
                      )),
                  Positioned(
                      top: 90.0,
                      left: 0.0,
                      child: Text("My Shop",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ))),
                  Positioned(
                      top: 120.0,
                      left: 20.0,
                      child: Text("Manage Your Shop Soo Easy !!! ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontStyle: FontStyle.italic,
                          ))),
                ])),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.deepPurple,
              ),
              title: Text(
                "All Product",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AllProudect();
                  }),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.monetization_on,
                size: 30,
                color: Colors.deepPurple,
              ),
              title: Text(
                "Monthly sales schedule",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Month();
                  }),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.monetization_on,
                size: 30,
                color: Colors.deepPurple,
              ),
              title: Text(
                "Full sales schedule",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Week();
                  }),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.deepPurple,
              ),
              title: Text(
                "Exit",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ));

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 6,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
        title: Text(
          'Your Proudect',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '${items.length} Items',
          style: TextStyle(color: Colors.white),
        ),
      );

  get grid => Expanded(
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
          child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: .90,
              children: List.generate(items.length, (i) {
                return Card(
                  color: Colors.deepPurple[50],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Center(
                          child: Text(
                            items[i].name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Salary: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${items[i].salary}",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Count: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${items[i].count}",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              ch(items[i].kg),
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                      RaisedButton(
                        elevation: 10,
                        padding: EdgeInsets.all(3),
                        onPressed: () async {
                          SharedPreferences sharedpreference =
                              await SharedPreferences.getInstance();
                          sharedpreference.setString("name", items[i].name);
                          sharedpreference.setString(
                              "id", items[i].id.toString());
                          sharedpreference.setString(
                              "kg", items[i].kg.toString());
                          sharedpreference.setString(
                              "proft", items[i].proft.toString());

                          sharedpreference.setString(
                              "fsalary", items[i].fsalary.toString());
                          sharedpreference.setString(
                              "salary", items[i].salary.toString());
                          sharedpreference.setString(
                              "count", items[i].count.toString());

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SellPage();
                          }));
                        },
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        child:
                            Text("Sell", style: TextStyle(color: Colors.white)),
                      ),
                      RaisedButton(
                        elevation: 10,
                        padding: EdgeInsets.all(3),
                        onPressed: () => show(items[i].name, items[i].salary,
                            items[i].count, items[i].proft),
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        child:
                            Text("Veiw", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }))));
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
                    ),
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
                    ),
                  ],
                ),
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

  void showbar(BuildContext context, String msg, int ch) {
    var col;
    if (ch == 0) {
      col = Colors.red;
    } else {
      col = Colors.green;
    }
    var bar = SnackBar(
      backgroundColor: col,
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(bar);
  }
}
