import 'package:flutter/material.dart';
import 'package:mission_control/models/task_model.dart';
import 'package:mission_control/models/task_type.dart';
import 'package:mission_control/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
  int _selectedIndex = 0;

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

  List<Task> _selectTasks() {
    switch (_selectedIndex) {
      case 0:
        return _filterTasks(TaskType.Capture);
      case 1:
        return _filterTasks(TaskType.NDN);
      case 2: 
        return _filterTasks(TaskType.NVDN);
      default:
        return _filterTasks(TaskType.Capture);
    }
  }

  String _handleTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Capture List';
      case 1:
        return 'NDN';
      case 2: 
        return 'NVDN';
      default:
        return 'Mission Control';
    }
  }

  void _selectMenu(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _selectTasks();
    return Scaffold(
      appBar: AppBar(
        title: Text(_handleTitle()),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TaskList(
              tasks: tasks,
              changeTaskState: _changeTaskState,
              changeTaskType: _changeTaskType,
              deleteTask: _deleteTask,
            )
          ),
          _selectedIndex == 0 ?
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
          ) :
          Container(),
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
        currentIndex: _selectedIndex,
        onTap: _selectMenu,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
