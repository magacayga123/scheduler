import 'package:equatable/equatable.dart';
import 'package:scheduler/model/schedule_skeleton.dart';

abstract class ScheduleStates extends Equatable {
  ScheduleStates();
  factory ScheduleStates.initialState() => InitialState();
  factory ScheduleStates.addedScheduleState() => AddedScheduleState();
  factory ScheduleStates.updatedSchedule() => UpdatedScheduleState();
  factory ScheduleStates.readed(List<Schedule_skeleton> schedules) =>
      SuccessfullyReadedSchedules(schedule_skeletons: schedules);
  factory ScheduleStates.successFullyAddedEvaluations(
          Schedule_skeleton schedule_skeleton) =>
      SuccessfullyAddedEvaluation(schedule_skeleton: schedule_skeleton);
  factory ScheduleStates.successfullyFindedSchedule(
          Schedule_skeleton schedule_skeleton) =>
      SuccessfullyFindedSchedule(schedule_skeleton: schedule_skeleton);
  factory ScheduleStates.loading() => loadingState();
  @override
  List<Object> get props => [];
}

class InitialState extends ScheduleStates {}

class loadingState extends ScheduleStates {}

class AddedScheduleState extends ScheduleStates {}

class UpdatedScheduleState extends ScheduleStates {}

class SuccessfullyReadedSchedules extends ScheduleStates {
  List<Schedule_skeleton> schedule_skeletons;
  SuccessfullyReadedSchedules({required this.schedule_skeletons});
  @override
  List<Object> get props => [schedule_skeletons];
}

class SuccessfullyAddedEvaluation extends ScheduleStates {
  Schedule_skeleton schedule_skeleton;
  SuccessfullyAddedEvaluation({required this.schedule_skeleton});

  @override
  List<Object> get props => [schedule_skeleton];
}

class SuccessfullyFindedSchedule extends ScheduleStates {
  Schedule_skeleton schedule_skeleton;
  SuccessfullyFindedSchedule({required this.schedule_skeleton});
  @override
  List<Object> get props => [schedule_skeleton];
}
