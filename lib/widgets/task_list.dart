import 'package:flutter/material.dart';
import 'package:mission_control/models/task_model.dart';
import 'package:mission_control/widgets/task_card.dart';

class TaskList extends StatelessWidget {

  const TaskList({
    Key key,
    this.listKey,
    this.tasks,
    this.changeTaskState,
    this.changeTaskType,
    this.deleteTask,
  }) : super(key: key);

  final GlobalKey<AnimatedListState> listKey;
  final List<Task> tasks;
  final Function changeTaskState;
  final Function changeTaskType;
  final Function deleteTask;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: tasks.length,
      itemBuilder: (context, int index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: TaskCard(
            task: tasks[index],
            changeTaskState: changeTaskState,
            changeTaskType: changeTaskType,
            deleteTask: deleteTask,
          ),
        );
      },
    );
  }
}