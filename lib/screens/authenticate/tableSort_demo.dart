import 'package:Cloudmon/screens/authenticate/users.dart';
import 'package:flutter/material.dart';
import 'api_manager.dart';
import 'demo_alarm.dart';

class SortablePage extends StatefulWidget {
  @override
  _SortablePageState createState() => _SortablePageState();
}

class _SortablePageState extends State<SortablePage> {
  late List<Data> data;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();

    this.data = List.of(data);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(child: buildDataTable()),
      );

  Widget buildDataTable() {
    final columns = ['Name', 'Alarms'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(data),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<Data> data) => data.map((Data user) {
        final cells = [
          user.name,
          user.alarms,
        ];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      data.sort((user1, user2) =>
          compareString(ascending, user1.alarms as String, user2.name));
    } else if (columnIndex == 1) {
      data.sort((user1, user2) =>
          compareString(ascending, user1.alarms as String, user2.name));
    } else if (columnIndex == 2) {
      data.sort((user1, user2) =>
          compareString(ascending, '${user1.alarms}', user2.name));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
