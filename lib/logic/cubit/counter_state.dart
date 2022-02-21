part of 'counter_cubit.dart';

class CounterState extends Equatable {
  int counterValue;
  bool isIncrement;

  CounterState({required this.counterValue, required this.isIncrement});

  @override
  List<Object?> get props => [this.counterValue, this.isIncrement];

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'isIncrement': isIncrement,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'] as int,
      isIncrement: map['isIncrement'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) {
    return CounterState.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'CounterState{counterValue: $counterValue, isIncrement: $isIncrement}';
  }
}
