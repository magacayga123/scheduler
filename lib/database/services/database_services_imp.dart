import 'dart:async';

import 'package:scheduler/database/services/database_services.dart';
import 'package:scheduler/model/schedule_skeleton.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServicesImpl implements DatabaseServices {
  final Database db;
  DatabaseServicesImpl({required this.db});
  StreamSubscription? subscription;
  final streamController = StreamController<Schedule_skeleton>.broadcast();
  @override
  Future<Schedule_skeleton> addEvaluations(
    List<int> indexes,
    String schedule_id,
    double evaluation,
  ) async {
    List<Map<String, dynamic>> scheduleskeletondata =
        await db.query("scheduler", where: 'id=?', whereArgs: [schedule_id]);
    final skeleton = Schedule_skeleton.fromjson(scheduleskeletondata.first);
    skeleton.body[indexes[0]][indexes[1]].evaluation = evaluation;
    return skeleton;
  }

  @override
  Future<void> addSchedule(Schedule_skeleton schedule_skeleton) async {
    await db.insert("scheduler", schedule_skeleton.tojson());
  }

  @override
  Stream<Schedule_skeleton> findAllSchedules() {
    final String sql = '''Select * from scheduler order by id desc''';
    subscription = db.rawQuery(sql).asStream().listen((event) {
      List<Map<String, dynamic>> schedulesdata = event;
      schedulesdata.forEach((singlescd) {
        final skeleton = Schedule_skeleton.fromjson(singlescd);
        streamController.sink.add(skeleton);
      });
    });
    return streamController.stream;
  }

  @override
  Future<Schedule_skeleton> findSchedule(String schedule_id) async {
    List<Map<String, dynamic>> scheduledata =
        await db.query("scheduler", where: 'id=?', whereArgs: [schedule_id]);
    return Schedule_skeleton.fromjson(scheduledata.first);
  }

  @override
  Future<void> updateSchedule(
      Schedule_skeleton newschedule_skeleton, String schedule_id) async {
    await db.update('scheduler', newschedule_skeleton.tojson(),
        where: 'id=?', whereArgs: [schedule_id]);
  }

  @override
  dispose() async {
    await subscription?.cancel();
    await streamController.close();
  }
}
