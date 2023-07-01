import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_event.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_state.dart';
import 'package:todo_bloc_pattern/models/models.dart';

class TodosBloc extends Bloc<TodosEvent,TodosState>{
  TodosBloc():super(TodoLoading()){
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodos>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  _onLoadTodos(LoadTodos event,Emitter<TodosState> emit){
    emit(TodoLoaded(todos: event.todos));
  }

  _onAddTodo(AddTodo event,Emitter<TodosState> emit){
    final state = this.state;
    if(state is TodoLoaded){
      List<Todo> newTodo = List.from(state.todos)..add(event.todos);
      emit(TodoLoaded(todos: newTodo));
    }

  }
  _onUpdateTodo(UpdateTodos event,Emitter<TodosState> emit){
    final state = this.state;
    if(state is TodoLoaded){
      final List<Todo> newList = state.todos.map((e) {
        return e.id==event.todos.id?event.todos:e;
      }).toList();

      emit(TodoLoaded(todos: newList));
    }

  }
  _onDeleteTodo(DeleteTodo event,Emitter<TodosState> emit){
    final state = this.state;
    if(state is TodoLoaded){
      List<Todo> newList = state.todos.where((element) => element.id!=event.todos.id).toList();
      emit(TodoLoaded(todos: newList));
    }
  }



}