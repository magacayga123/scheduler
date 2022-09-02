import 'package:scheduler/model/schedule_skeleton.dart';

abstract class DatabaseServices {
  Stream<Schedule_skeleton> findAllSchedules();
  Future<Schedule_skeleton> findSchedule(String schedule_id);
  Future<void> addSchedule(Schedule_skeleton schedule_skeleton);
  Future<void> updateSchedule(
      Schedule_skeleton newschedule_skeleton, String schedule_id);
  Future<Schedule_skeleton> addEvaluations(
      List<int> indexes,
      String schedule_id, double evaluation);
  dispose();
}
