import 'package:flutter/material.dart';
import 'package:my_own_cubit/my_state_management/my_cubit.dart';
import 'package:my_own_cubit/my_state_management/my_provider.dart';

class MyBlocBuilder<C extends MyCubit<S>, S> extends StatefulWidget {
  const MyBlocBuilder({
    super.key,
    required this.builder,
    this.buildWhen,
  });
  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S previousState, S currentState)? buildWhen;

  @override
  State<MyBlocBuilder<C, S>> createState() => _MyBlocBuilderState<C, S>();
}

class _MyBlocBuilderState<C extends MyCubit<S>, S>
    extends State<MyBlocBuilder<C, S>> {
  S? previousState;

  @override
  Widget build(BuildContext context) {
    C cubit = MyBlocProvider.of<C>(context);
    previousState ??= cubit.state;
    return ValueListenableBuilder<S>(
      valueListenable: cubit,
      builder: (context, state, child) {
        if (widget.buildWhen != null &&
            !widget.buildWhen!(previousState as S, state)) {
          return widget.builder(context, previousState as S);
        }
        previousState = state;
        return widget.builder(context, state);
      },
    );
  }
}
