import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cubit_bloc_1_example/logic/cubit/internet_cubit.dart';
import 'package:cubit_bloc_1_example/logic/cubit/settings_cubit.dart';
import 'package:cubit_bloc_1_example/presentation/router/app_router.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/utility/app_bloc_utility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //settings for android platform
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
//settings for ios platform
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            didReceiveLocalNotificationSubject.add(
              ReceivedNotification(
                id: id,
                title: title,
                body: body,
                payload: payload,
              ),
            );
          });
// initialize platform specific settings
final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  //initialize 
await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload);
  });
//getting storage directory
  final deviceStorage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  final observer = AppBlocObserver();

  HydratedBlocOverrides.runZoned(
      () => runApp(MyApp(
            appRouter: AppRouter(),
            connectivity: Connectivity(),
          )),
      storage: deviceStorage,
      blocObserver: observer);
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.connectivity,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
