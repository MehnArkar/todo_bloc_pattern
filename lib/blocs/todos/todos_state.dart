import 'package:equatable/equatable.dart';
import 'package:todo_bloc_pattern/models/models.dart';

abstract class TodosState extends Equatable{
  const TodosState();

  @override
  List<Object> get props =>[];
}

class TodoLoading extends TodosState{}

class TodoLoaded extends TodosState{
  final List<Todo> todos;

  const TodoLoaded({this.todos=const <Todo>[]});

  @override
  List<Object> get props =>[todos];
}