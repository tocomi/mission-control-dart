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

  final TextEditingController _controller = new TextEditingController();
  String _capture = '';

  void _handleCapture(String e) {
    setState(() {
      _capture = e;
    });
  }

  void _addCapture() {
    if (_capture == '') return;

    Task task = Task(
      _tasks.last.id + 1,
      _capture,
      TaskType.Capture,
      false,
      DateTime.now()
    );
    _tasks.add(task);

    setState(() {
      _capture = '';
    });
    _controller.clear();
  }

  void _changeTaskState(int id) {
    final Task target = _tasks.firstWhere((task) => task.id == id);
    setState(() {
      target.done = !target.done;
    });
  }

  void _deleteTask(int id) {
    final int index = _tasks.indexWhere((task) => task.id == id);
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _changeTaskType(int id, TaskType taskType) {
    final Task target = _tasks.firstWhere((task) => task.id == id);
    setState(() {
      target.type = taskType;
    });
  }

  List<Task> _filterTasks(TaskType taskType) {
    return _tasks.where((task) => task.type == taskType).toList();
  }

  @override
  Widget build(BuildContext context) {
    final capturedTasks = _filterTasks(TaskType.Capture);
    final ndnTasks = _filterTasks(TaskType.NDN);
    final nvdnTasks = _filterTasks(TaskType.NVDN);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission Control'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: capturedTasks.length,
              itemBuilder: (context, int index) {
                return TaskCard(
                  task: capturedTasks[index],
                  changeTaskState: _changeTaskState,
                  changeTaskType: _changeTaskType,
                  deleteTask: _deleteTask,
                );
              },
            )
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onChanged: _handleCapture,
              decoration: InputDecoration(
                hintText: '何をキャプチャしますか？',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addCapture,
                )
              ),
            ),
          ),
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
