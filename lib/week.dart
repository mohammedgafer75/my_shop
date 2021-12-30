import 'package:flutter/material.dart';
import 'package:myshop/sql_helper.dart';

import 'model/sells.dart';

class Week extends StatefulWidget {
  Week({Key key}) : super(key: key);

  @override
  _WeekState createState() => _WeekState();
}

class _WeekState extends State<Week> {
  void initState() {
    super.initState();
    helper.getSells().then((sells) {
      setState(() {
        sells.forEach((sells) {
          items2.add(Sells.getMap(sells));
        });
      });
    });
  }

  List<Sells> items2 = new List();
  Sql_Helper helper = new Sql_Helper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Week"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Stack(children: <Widget>[
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
              ]))
        ]));
  }
}
