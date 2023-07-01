import 'package:equatable/equatable.dart';

import '../../models/todos_model.dart';

abstract class TodosEvent extends Equatable{
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodosEvent{
  final List<Todo> todos;
  const LoadTodos({this.todos = const []});

  @override
  List<Object> get props => [todos];
}

class AddTodo extends TodosEvent{
  final Todo todos;
  const AddTodo({required this.todos});

  @override
  List<Object> get props => [todos];
}

class UpdateTodos extends TodosEvent{
  final Todo todos;
  const UpdateTodos({required this.todos});

  @override
  List<Object> get props => [todos];
}

class DeleteTodo extends TodosEvent{
  final Todo todos;
  const DeleteTodo({required this.todos});

  @override
  List<Object> get props => [todos];
}

