import 'package:flutter/material.dart';
import 'package:mission_control/models/task_model.dart';
import 'package:mission_control/models/task_type.dart';
import 'package:mission_control/widgets/task_card.dart';

class CaptureScreen extends StatefulWidget {
  @override
  _CaptureScreenState createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {

  final List<Task> _tasks = [
    new Task(
      1,
      'キャプチャキャプチャ',
      TaskType.Capture,
      false,
      DateTime.now(),
    ),
    new Task(
      2,
      'キャプチャキャプチャキャプチャキャプチャ',
      TaskType.Capture,
      false,
      DateTime.now(),
    ),
    new Task(
      3,
      'キャプチャキャプチャキャプチャキャプチャキャプチャキャプチャ',
      TaskType.Capture,
      false,
      DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission Control'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, int index) {
                return TaskCard(task: _tasks[index]);
              },
            )
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '何をキャプチャしますか？',
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Capture'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('NDN'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('NVDN'),
          ),
        ],
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
