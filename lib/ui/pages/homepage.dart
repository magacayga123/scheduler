import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/state_management/app_states.dart';
import 'package:scheduler/state_management/app_states_cubit.dart';
import 'package:scheduler/ui/pages/input_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<AppStateCubit>()
    return Scaffold(
      appBar: AppBar(
        title: Text("Scheduler app"),
      ),
      body: BlocBuilder<AppStatesCubit, ScheduleStates>(
        builder: (c, state) {
          if (state is loadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SuccessfullyReadedSchedules) {
            return ListView.builder(
              itemBuilder: (c, i) {
                return ListTile(
                  leading: CircleAvatar(),
                  title: Text(state.schedule_skeletons[i].timetableName),
                  subtitle: Row(children: [
                    Text(state.schedule_skeletons[i].startDate.toString()),
                    Text("_"),
                    Text(state.schedule_skeletons[i].endDate.toString()),
                  ]),
                );
              },
              itemCount: state.schedule_skeletons.length,
            );
          } else {
            return Center(
              child: Text("no data"),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final route = MaterialPageRoute(builder: (_) => InputWidget());
          Navigator.of(context).push(route);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
