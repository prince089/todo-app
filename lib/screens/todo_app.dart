import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final todos = todoProvider.todos;
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text('Date: ${DateFormat.yMd().format(todo.date)}'),
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (_) {
                todoProvider.toggleTodoDone(index);
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.star),
              color: todo.isHighPriority ? Colors.yellow : Colors.grey,
              onPressed: () {
                todoProvider.toggleTodoPriority(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _showAddTodoDialog(context);
          TextEditingController titleController = TextEditingController();
          DateTime selectedDate = DateTime.now();
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(labelText: 'Task Title'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final title = titleController.text;
                        if (title.isNotEmpty) {
                          final newTodo = Todo(
                            title: title,
                            date: selectedDate,
                          );
                          todoProvider.addTodo(newTodo);
                          Navigator.of(context).pop();
                          _showTaskAddedAnimation(context);
                        }
                      },
                      child: Text('Add Task'),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        ).then((value) {
                          if (value != null) {
                            selectedDate = value;
                          }
                        });
                      }, child: const Text("Select Date"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  void _showTaskAddedAnimation(BuildContext context) {

  }
}
