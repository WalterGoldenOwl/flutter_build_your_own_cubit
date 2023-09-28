import 'package:flutter/material.dart';
import 'package:my_own_cubit/feature/simple_counter_cubit/logic/simple_counter_state.dart';
import 'package:my_own_cubit/my_state_management/my_builder.dart';
import 'package:my_own_cubit/my_state_management/my_cubit.dart';
import 'package:my_own_cubit/my_state_management/my_provider.dart';

import 'logic/simple_counter_bloc.dart';

class SimpleCounterWithCubit extends StatelessWidget {
  const SimpleCounterWithCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return MyBlocProvider(
      create: (_) => SimpleCounterBloc(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleCounterPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class SimpleCounterPage extends StatefulWidget {
  const SimpleCounterPage({super.key, required this.title});

  final String title;

  @override
  State<SimpleCounterPage> createState() => _SimpleCounterPageState();
}

class _SimpleCounterPageState extends State<SimpleCounterPage> {
  @override
  Widget build(BuildContext context) {
    print("build counter");
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            MyBlocBuilder<SimpleCounterBloc, SimpleCounterState>(
              buildWhen: (previousState, currentState) {
                print("previousState ${previousState.count}");
                print("currentState ${currentState.count}");
                return currentState.count % 2 == 0;
              },
              builder: (context, state) {
                return Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<SimpleCounterBloc>().increase,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
