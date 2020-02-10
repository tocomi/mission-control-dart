import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mission_control/models/task_model.dart';
import 'package:mission_control/models/task_type.dart';

class TaskCard extends StatelessWidget {

  const TaskCard({
    Key key,
    this.task,
    this.changeTaskState,
    this.changeTaskType,
    this.deleteTask,
  }) : super(key: key);

  final Task task;
  final Function changeTaskState;
  final Function changeTaskType;
  final Function deleteTask;

  final double _itemHeight = 72.0;
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
                      child: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.done ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 8.0, left: 8.0),
                    child: Text(
                    new DateFormat('yyyy/MM/dd').format(task.createdAt),
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
                GestureDetector(
                  onTap: () {
                    changeTaskState(task.id);
                  },
                  child: Container(
                    height: 24.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.green[400],
                      )
                    ),
                    child: new Icon(
                      Icons.check,
                      color: Colors.green[400],
                      size: 16.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    changeTaskType(task.id, TaskType.NDN);
                  },
                  child: Container(
                    height: 24.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.blueAccent,
                      )
                    ),
                    child: Center(
                      child: Text(
                        'ND',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        )
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    changeTaskType(task.id, TaskType.NVDN);
                  },
                  child: Container(
                    height: 24.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.yellow[700],
                      )
                    ),
                    child: Center(
                      child: Text(
                        'NV',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[700],
                        )
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    deleteTask(task.id);
                  },
                  child: Container(
                    height: 24.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.red,
                      )
                    ),
                    child: new Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 16.0,
                    ),
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