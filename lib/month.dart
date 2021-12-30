import 'package:flutter/material.dart';
import 'package:myshop/sql_helper.dart';

import 'model/sells.dart';

class Month extends StatefulWidget {
  Month({Key key}) : super(key: key);

  @override
  _MonthState createState() => _MonthState();
}

class _MonthState extends State<Month> {
  void initState() {
    super.initState();
    var datenow = new DateTime.now();
    var day = datenow.month.toString();
    helper.getSellDay(day).then((sells) {
      setState(() {
        sells.forEach((sells) {
          items2.add(Sells.getMap(sells));
        });
      });
    });
  }

  Sql_Helper helper = new Sql_Helper();
  List<Sells> items2 = new List();
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Month"),
              backgroundColor: Colors.deepPurple,
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  color: Colors.deepPurple,
                ),
                Card(
                  margin: EdgeInsets.all(30),
                  color: Colors.deepPurple[50],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: ListView(children: <Widget>[
                    DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Count',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Profit',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: items2
                            .map((e) => DataRow(cells: <DataCell>[
                                  DataCell(Text(e.itemName)),
                                  DataCell(Text("${e.count}")),
                                  DataCell(Text("${e.proft}"))
                                ]))
                            .toList())
                  ]),
                )
              ],
            )));
  }
}
