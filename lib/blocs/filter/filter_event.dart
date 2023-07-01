import 'package:equatable/equatable.dart';
import 'package:todo_bloc_pattern/models/todo_filter_model.dart';

import '../../models/todos_model.dart';

abstract class FilterEvent extends Equatable{
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilter extends FilterEvent{
  const UpdateFilter();

  @override
  List<Object> get props => [];
}

class UpdateTodo extends FilterEvent{
  final TodosFilter filter;
  const UpdateTodo({ this.filter=TodosFilter.all});

  @override
  List<Object> get props => [filter];
}