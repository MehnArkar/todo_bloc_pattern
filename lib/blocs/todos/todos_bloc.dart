import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_event.dart';
import 'package:todo_bloc_pattern/blocs/todos/todos_state.dart';

class TodosBloc extends Bloc<TodosEvent,TodosState>{
  TodosBloc():super(TodoLoading()){
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  _onLoadTodos(LoadTodos event,Emitter<TodosState> emit){
    emit(TodoLoaded(todos: event.todos));
  }

  _onAddTodo(AddTodo event,Emitter<TodosState> emit){

  }
  _onUpdateTodo(UpdateTodo event,Emitter<TodosState> emit){

  }
  _onDeleteTodo(DeleteTodo event,Emitter<TodosState> emit){

  }



}