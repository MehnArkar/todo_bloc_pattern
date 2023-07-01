import 'package:equatable/equatable.dart';
import 'package:todo_bloc_pattern/models/todo_filter_model.dart';

import '../../models/todos_model.dart';

abstract class FilterState extends Equatable{
  const FilterState();
  @override
  List<Object> get props=>[];
}

class FilterLoading extends FilterState{
  @override
   List<Object> get props=>[];
}

class FilterLoaded extends FilterState{
  final List<Todo> filterTodos;
  final TodosFilter filter;

  const FilterLoaded({required this.filterTodos,this.filter=TodosFilter.all});

  @override
  List<Object> get props=>[filterTodos,filter];
}