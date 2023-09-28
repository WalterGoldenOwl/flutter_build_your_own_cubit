import 'package:flutter/material.dart';

import 'feature/simple_counter_cubit/simple_counter.dart';
import 'feature/simple_counter_notifier/simple_counter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final int type = 1;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 0:
        return SimpleCounterWithNotifier();
      case 1:
        return SimpleCounterWithCubit();
      default:
        return SizedBox();
    }
  }
}
