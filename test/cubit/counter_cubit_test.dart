import 'package:bloc_test/bloc_test.dart';
import 'package:cubit_bloc_1_example/logic/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    CounterCubit counterCubit = CounterCubit();

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });
    test('initial state of counterValue', () {
      expect(counterCubit.state,
          CounterState(counterValue: 0, isIncrement: false));
    });
    blocTest(
      'When cubit.increment() function is called should be emit(counterValue: 1, isIncrement: true)',
      build: () => counterCubit,
      act: (cubit) => counterCubit.increment(),
      expect: ()=>[CounterState(counterValue: 1, isIncrement: true)],
    );
    blocTest(
      'When cubit.decrement() function is called should be emit(counterValue: -1, isIncrement: false)',
      build: () => counterCubit,
      act: (cubit) => counterCubit.decrement(),
      expect: ()=>[CounterState(counterValue: -1, isIncrement: false)],
    );
  });
}
