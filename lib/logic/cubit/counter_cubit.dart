import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  final AudioCache audioPlayer = AudioCache();

  CounterCubit() : super(CounterState(counterValue: 0, isIncrement: false)) {}
  void increment() {
    playAudio('audio/increment.mp3');
    emit(
      CounterState(counterValue: state.counterValue + 1, isIncrement: true),
    );
  }

  void decrement() {
    playAudio('audio/decrement.mp3');
    emit(
        CounterState(counterValue: state.counterValue - 1, isIncrement: false));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }

  void playAudio(String url) async {
    final result = await audioPlayer.play(url);
    result;
  }
}
