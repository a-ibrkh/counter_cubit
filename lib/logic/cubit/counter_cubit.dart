import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/subjects.dart';

part 'counter_state.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();
const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');
String? selectedNotificationPayload;

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  final AudioCache audioPlayer = AudioCache();

  CounterCubit() : super(CounterState(counterValue: 0, isIncrement: false)) {}
  void increment() {
    //playAudio('audio/increment.mp3');
    _showNotification("Addition");
    emit(
      CounterState(counterValue: state.counterValue + 1, isIncrement: true),
    );
  }

  void decrement() {
    //playAudio('audio/decrement.mp3');
    _showNotification("Subtraction");
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

  Future<void> _showNotification(String action) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '5',
      'notification',
      channelDescription: 'with sound',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound("decrement"),
    );
    NotificationDetails platformChannelSpecifics =
        const NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Change: ',
      action.toString() + " performed",
      platformChannelSpecifics,
    );
  }
}
