import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/filter/filter_event.dart';
import 'package:todo_bloc_pattern/blocs/filter/filter_state.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_state.dart';
import 'package:todo_bloc_pattern/models/todo_filter_model.dart';

import '../../models/todos_model.dart';

class FilterBloc extends Bloc<FilterEvent,FilterState>{
  final TodosBloc _todosBloc;
  late StreamSubscription _todoSubscription;
  FilterBloc({required TodosBloc todosBloc}): _todosBloc=todosBloc,super(FilterLoading()){
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateTodo>(_onUpdateTodo);
   
    _todoSubscription = _todosBloc.stream.listen((state) {
      add(const UpdateFilter());
    });
  }

  void _onUpdateFilter(UpdateFilter event,Emitter<FilterState> emit){
    final state = this.state;
    if(state is FilterLoading){
      add(const UpdateTodo(filter:TodosFilter.pending));
    }

    if(state is FilterLoaded){
      add( UpdateTodo(filter: state.filter));
    }
  }

  void _onUpdateTodo(UpdateTodo event,Emitter<FilterState> emit){
      final state = _todosBloc.state;
      if(state is TodoLoaded){
        List<Todo> list = state.todos.where((todo) {
          switch (event.filter) {
            case TodosFilter.all:
            return true;
            case TodosFilter.complete:
              return todo.isCompleted!;
            case TodosFilter.canceled:
              return todo.isCancelled!;
            case TodosFilter.pending:
              return !(todo.isCancelled! || todo.isCompleted!);
          }
        }
        ).toList();

        emit(FilterLoaded(filterTodos: list,filter: event.filter));

      }
  }

}