import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/database/factory/db_factory.dart';
import 'package:scheduler/database/services/database_services.dart';
import 'package:scheduler/database/services/database_services_imp.dart';
// import 'package:scheduler/pages/homepage.dart';
import 'package:scheduler/state_management/app_states.dart';
import 'package:scheduler/state_management/app_states_cubit.dart';
import 'package:scheduler/themes.dart';
import 'package:scheduler/ui/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TDatabase.createDatabase();
  final services = DatabaseServicesImpl(db: TDatabase.getDatabase);
  runApp(ScheduleApp(
    services: services,
  ));
}

class ScheduleApp extends StatelessWidget {
  final DatabaseServices services;
  ScheduleApp({required this.services});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemesControler.lightState(),
      themeMode: ThemeMode.system,
      home: BlocProvider<AppStatesCubit>(
          create: (_c) =>
              AppStatesCubit(ScheduleStates.initialState(), services: services),
          child: HomePage()),
    );
  }
}
