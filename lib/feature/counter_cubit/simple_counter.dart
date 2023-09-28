import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_cubit/feature/counter_cubit/logic/counter_cubit.dart';
import 'logic/counter_state.dart';

class CounterWithCubit extends StatelessWidget {
  const CounterWithCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
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
            BlocBuilder<CounterBloc, CounterState>(
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
        onPressed: context.read<CounterBloc>().increase,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
