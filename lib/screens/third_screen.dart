import 'package:cubit_bloc_1_example/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);
  static const routeName = '/thirdScreen';


  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen',),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                  Text(state.isIncrement ? 'Incremented' : 'Decremented!'),
                  duration: Duration(milliseconds: 100),
                ));
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: TextStyle(fontSize: 48.0),
                );
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: '1',
                      onPressed: () {
                        bloc.increment();
                      },
                      tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                    if (state.counterValue > 0)
                      FloatingActionButton(
                        onPressed: () {
                          bloc.decrement();
                        },
                        tooltip: 'Decrement',
                        child: Icon(Icons.remove),
                      ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 24.0,
            ),

          ],
        ),
      ),
    );
  }
}
