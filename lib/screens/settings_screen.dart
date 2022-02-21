import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_bloc_1_example/logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = '/settingsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text('Settings'),
        centerTitle: false,
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificationSnackBar = SnackBar(
            content: Text(
              'App notifications ' +
                  state.appNotifications.toString() +
                  ' Email notifications ' +
                  state.emailNotifications.toString(),
            ),
            duration: Duration(milliseconds: 100),
          );
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Container(
              child: Column(
                children: [
                  SwitchListTile(
                    value: state.appNotifications,
                    onChanged: (newValue) {
                      context
                          .read<SettingsCubit>()
                          .toggleAppNotifications(newValue);
                    },
                    title: const Text(
                      'App Notifications',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SwitchListTile(
                    value: state.emailNotifications,
                    onChanged: (newValue) {
                      context
                          .read<SettingsCubit>()
                          .toggleEmailNotifications(newValue);
                    },
                    title: const Text(
                      'Email Notifications',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
