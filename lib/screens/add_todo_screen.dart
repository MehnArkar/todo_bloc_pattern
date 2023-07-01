import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_event.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_state.dart';
import '/models/models.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: Add a To Do'),
      ),
      body: BlocListener<TodosBloc,TodosState>(
        listener: (context,state){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New todo addes!'),)
          );
        },
        child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _inputField('ID', controllerId),
                        _inputField('Task', controllerTask),
                        _inputField('Description', controllerDescription),
                        ElevatedButton(
                          onPressed: () {
                            final todo = Todo(id: controllerId.text.trim(), task: controllerTask.text.trim(), description: controllerDescription.text.trim());
                            context.read<TodosBloc>().add(AddTodo(todos: todo));
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          child: const Text('Add To Do'),
                        ),
                      ],
                    ),
                  ),
                )
      )
    );
  }

  Column _inputField(
    String field,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
