import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/filter/filter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/filter/filter_state.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_event.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_state.dart';
import 'package:todo_bloc_pattern/models/todo_filter_model.dart';
import '../blocs/filter/filter_event.dart';
import '/models/models.dart';
import '/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            onTap: (index){
              if(index==0){
                BlocProvider.of<FilterBloc>(context).add(const UpdateTodo(filter: TodosFilter.pending));
              }

              if(index==1){
                BlocProvider.of<FilterBloc>(context).add(const UpdateTodo(filter: TodosFilter.complete));
              }
            },
              tabs: const [
                Tab(icon: Icon(Icons.pending),),
                Tab(icon: Icon(Icons.add_task),)
              ]
          ),
        ),
        body:TabBarView(
          children: [
            _todo('Pending'),
            _todo('Complete')
          ],
        )
      ),
    );
  }

  BlocBuilder<FilterBloc, FilterState> _todo(String status) {
    return BlocBuilder<FilterBloc,FilterState>(
      builder:(context,state) {
        // if(state is FilterLoading){
        //   return const Center(child: CircularProgressIndicator(),);
        // }

        if(state is FilterLoaded) {
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
                itemCount: state.filterTodos.length,
                itemBuilder: (BuildContext context, int index) {
                  return _todosCard(
                    context,
                    state.filterTodos[index],
                  );
                },
              ),
            ],
          );
      }else{
          return Container();
        }
      }
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
                        context.read<TodosBloc>().add(UpdateTodos(todos: todo.copyWith(isCompleted: true)));
                      },
                      icon: const Icon(Icons.add_task),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<TodosBloc>().add(DeleteTodo(todos: todo));
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
