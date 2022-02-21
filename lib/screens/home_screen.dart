import 'package:cubit_bloc_1_example/consts/enums.dart';
import 'package:cubit_bloc_1_example/logic/cubit/counter_cubit.dart';
import 'package:cubit_bloc_1_example/logic/cubit/internet_cubit.dart';
import 'package:cubit_bloc_1_example/screens/second_screen.dart';
import 'package:cubit_bloc_1_example/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  static const routeName = '/';

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Wifi) {
                return const Text(
                  'WIFI',
                  style: TextStyle(color: Colors.green, fontSize: 36.0),
                );
              } else if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Mobile) {
                return const Text(
                  'Mobile',
                  style: TextStyle(color: Colors.red, fontSize: 36.0),
                );
              } else if (state is InternetDisconnected) {
                return const Text(
                  'DISCONNECTED',
                  style: TextStyle(color: Colors.grey, fontSize: 36.0),
                );
              }
              return CircularProgressIndicator.adaptive();
            }),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: FittedBox(
                    child: Text(
                      state.counterValue.toString(),
                      style: TextStyle(fontSize: 48.0),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;
              if (internetState is InternetConnected) {
                return FittedBox(
                  child: Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Connection: ' +
                        (internetState.connectionType == ConnectionType.Wifi
                            ? 'Wifi'
                            : 'Mobile'),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                );
              } else {
                return Text(
                  'Counter: ' +
                      counterState.counterValue.toString() +
                      ' Connection: Disconnected',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                  ),
                );
              }
            }),
            const SizedBox(
              height: 16.0,
            ),
            Builder(builder: (context) {
              final wasIncremented = context
                  .select((CounterCubit cubit) => cubit.state.isIncrement);
              return Text(
                'Was incremented: ' + wasIncremented.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red.shade700,
                ),
              );
            }),
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
                        context.read<CounterCubit>().increment();
                      },
                      tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                    if (state.counterValue > 0)
                      FloatingActionButton(
                        onPressed: () {
                          context.read<CounterCubit>().decrement();
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SecondScreen.routeName);
              },
              child: Text(
                'Go to second screen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
