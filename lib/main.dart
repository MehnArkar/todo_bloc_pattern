import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/filter/filter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_event.dart';
import 'package:todo_bloc_pattern/models/models.dart';
import '/screens/screens.dart';
import 'blocs/todos/todos_bloc.dart';

void main() {
      runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>TodosBloc()..add(
            LoadTodos(todos: [
              Todo(id: '1', task: 'Todo 1', description: 'do now'),
        Todo(id: '2', task: 'Todo 2', description: 'do now')
            ])
        )
        ),
        BlocProvider(create: (context)=>FilterBloc(todosBloc: BlocProvider.of<TodosBloc>(context)))
      ],
      child:  MaterialApp(
          title: 'BloC Pattern - Todos',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF000A1F),
            appBarTheme: const AppBarTheme(
              color: Color(0xFF000A1F),
            ),
          ),
          home: const HomeScreen(),
        )
    );
  }
}
