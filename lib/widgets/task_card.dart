import 'package:flutter/material.dart';
import 'package:mission_control/models/task_model.dart';

class TaskCard extends StatelessWidget {

  const TaskCard({
    Key key,
    this.task,
  }) : super(key: key);

  final Task task;

  final double _itemHeight = 80.0;
  final double _buttonWidth = 36.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: _itemHeight,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300],
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(task.title),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 8.0, left: 8.0),
                    child: Text(
                      '2020/02/01',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.blueAccent,
                  height: _itemHeight,
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: new Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.green[400],
                  height: _itemHeight,
                  width: _buttonWidth,
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    'ND',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.yellow[600],
                  height: _itemHeight,
                  width: _buttonWidth,
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    'NV',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
                Container(
                  color: Colors.red,
                  height: _itemHeight,
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: new Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}