import 'package:flutter/material.dart';
import 'package:mission_control/models/task_model.dart';
import 'package:mission_control/models/task_type.dart';
import 'package:mission_control/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Task> _captures = [
    new Task(
      BigInt.from(1),
      'キャプチャキャプチャ',
      TaskType.Capture,
      false,
      DateTime.now(),
    ),
    new Task(
      BigInt.from(2),
      'キャプチャキャプチャキャプチャキャプチャ',
      TaskType.Capture,
      false,
      DateTime.now(),
    ),
  ];
  List<Task> _ndns = [
    new Task(
      BigInt.from(3),
      'キャプチャキャプチャキャプチャキャプチャキャプチャキャプチャ',
      TaskType.NDN,
      false,
      DateTime.now(),
    ),
  ];
  List<Task> _nvdns = [
    new Task(
      BigInt.from(4),
      'NVDNNVDNNVDN',
      TaskType.NVDN,
      false,
      DateTime.now(),
    ),
  ];

  GlobalKey<AnimatedListState> _capturesKey = GlobalKey<AnimatedListState>();
  GlobalKey<AnimatedListState> _ndnsKey = GlobalKey<AnimatedListState>();
  GlobalKey<AnimatedListState> _nvdnsKey = GlobalKey<AnimatedListState>();

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

    BigInt newId = _makeNewId();
    Task task = Task(
      newId,
      _capture,
      TaskType.Capture,
      false,
      DateTime.now()
    );

    setState(() {
      _captures.add(task);
      _capture = '';
    });
    _controller.clear();
  }

  void _changeTaskState(BigInt id) {
    final taskList = _selectTaskListByCurrentScreen();
    final Task target = taskList.firstWhere((task) => task.id == id);
    setState(() {
      target.done = !target.done;
    });
  }

  void _deleteTask(BigInt id) {
    final taskList = _selectTaskListByCurrentScreen();
    final int index = taskList.indexWhere((task) => task.id == id);
    setState(() {
      taskList.removeAt(index);
    });
  }

  void _changeTaskType(BigInt id, TaskType taskType) {
    final removeTaskList = _selectTaskListByCurrentScreen();
    final int targetIndex = removeTaskList.indexWhere((task) => task.id == id);
    final Task targetTask = removeTaskList[targetIndex];
    final targetTaskList = _selectTaskListByType(taskType);

    setState(() {
      targetTask.type = taskType;
      targetTaskList.add(targetTask);
      targetTaskList.sort((a, b) => a.id.compareTo(b.id));
    });

    setState(() {
      removeTaskList.removeAt(targetIndex);
    });
  }

  List<Task> _selectTaskListByCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return _captures;
      case 1:
        return _ndns;
      case 2: 
        return _nvdns;
      default:
        return _captures;
    }
  }

  List<Task> _selectTaskListByType(TaskType taskType) {
    switch (taskType) {
      case TaskType.Capture:
        return _captures;
      case TaskType.NDN:
        return _ndns;
      case TaskType.NVDN: 
        return _nvdns;
      default:
        return _captures;
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

  bool canComplete() {
    if (_captures.length == 0) return false;

    return !_captures.any((task) => task.done == false);
  }

  void _completeToday() {
    if (!canComplete()) return;

    setState(() {
      _captures.clear();
    });
  }

  Widget _buildCompleteButton() {
    return canComplete() ? FloatingActionButton.extended(
      backgroundColor: Colors.blueAccent,
      icon: Icon(
        Icons.playlist_add_check,
        color: Colors.white,
      ),
      label: Text(
        '完了する',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: _completeToday,
    ) : FloatingActionButton.extended(
      backgroundColor: Colors.grey,
      icon: Icon(
        Icons.playlist_add_check,
        color: Colors.white,
      ),
      label: Text(
        '完了する',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {},
    );
  }

  void _selectMenu(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BigInt _makeNewId() {
    DateTime now = DateTime.now();
    String timeString = now.year.toString()
      + now.month.toString().padLeft(2, "0")
      + now.day.toString().padLeft(2, "0")
      + now.hour.toString().padLeft(2, "0")
      + now.minute.toString().padLeft(2, "0")
      + now.second.toString().padLeft(2, "0")
      + now.millisecond.toString().padLeft(3, "0")
      + now.microsecond.toString().padLeft(3, "0");
    return BigInt.parse(timeString);
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _selectTaskListByCurrentScreen();
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
      floatingActionButton: _selectedIndex == 0 ? Container(
        margin: EdgeInsets.only(bottom: 60.0),
        child: _buildCompleteButton(),
      ) : Container(),
    );
  }
}
