import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/database/services/database_services.dart';
import 'package:scheduler/model/schedule_skeleton.dart';
import 'package:scheduler/state_management/app_states.dart';
// import 'package:sqflite/sqflite.dart';

class AppStatesCubit extends Cubit<ScheduleStates> {
  final DatabaseServices services;

  AppStatesCubit(ScheduleStates initialState, {required this.services})
      : super(initialState);
  // AppStatesCubit(ScheduleStates initialState,Database db) : super(initialState);
  Future<void> AddSchedule(Schedule_skeleton schedule_skeleton) async {
    emit(loadingState());
    services.addSchedule(schedule_skeleton);
    emit(AddedScheduleState());
  }

  Future<void> readAllSchedules() async {
    emit(loadingState());
    List<Schedule_skeleton> skeletons = [];
    services.findAllSchedules().listen((event) {
      skeletons.add(event);
    }, onDone: () {
      emit(SuccessfullyReadedSchedules(schedule_skeletons: skeletons));
    });
  }

  Future<void> updateSchedule(
      String schedule_id, Schedule_skeleton newschedule_skeleton) async {
    emit(loadingState());
    services.updateSchedule(newschedule_skeleton, schedule_id);
    emit(UpdatedScheduleState());
  }

  Future<void> findSchedule(String schedule_id) async {
    emit(loadingState());
    Schedule_skeleton skeleton = await services.findSchedule(schedule_id);
    emit(SuccessfullyFindedSchedule(schedule_skeleton: skeleton));
  }

  Future<void> addEvaluation(
      String schedule_id, double evaluation, List<int> position) async {
    emit(loadingState());
    final skeleton =
        await services.addEvaluations(position, schedule_id, evaluation);
    emit(SuccessfullyAddedEvaluation(schedule_skeleton: skeleton));
  }
}
