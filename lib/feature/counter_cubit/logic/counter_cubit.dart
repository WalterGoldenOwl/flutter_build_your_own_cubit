import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_state.dart';

class CounterBloc extends Cubit<CounterState> {
  CounterBloc() : super(CounterState());

  void increase() {
    int count = state.count + 1;
    emit(state.copyWith(count: count));
  }
}
