import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterIntialStates());

  int counter = 0 ;
  static CounterCubit get(context)=> BlocProvider.of(context);

  void minus(){
    counter--;
    emit(CounterMinusStates());
  }

  void plus(){
    counter++;
    emit(CounterPlusStates());
  }
}