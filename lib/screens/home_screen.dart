import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_state.dart';
import '/models/models.dart';
import '/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: To Dos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodosBloc,TodosState>(
        builder: (context,state) {
          if(state is TodoLoading){
            return const Center(child: CircularProgressIndicator(),);
          }

          if(state is TodoLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Pending To dos',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.todos.length,
                      itemBuilder: (context,index){
                        return _todosCard(context, state.todos[index]);
                      })
                ],
              ),
            );
          }else{
            return Center(child: Text('Somethings went wrong'),);
          }
        }
      )
    );
  }

  Column _todo(List<Todo> todos, String status) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Text(
                '$status To Dos: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return _todosCard(
              context,
              todos[index],
            );
          },
        ),
      ],
    );
  }

  Card _todosCard(
    BuildContext context,
    Todo todo,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${todo.id}: ${todo.task}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
                  children: [
                    IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.add_task),
                    ),
                    IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                )
          ],
        ),
      ),
    );
  }
}
