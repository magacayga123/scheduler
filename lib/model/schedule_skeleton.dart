import 'dart:convert';

import 'package:scheduler/model/single_work.dart';

class Schedule_skeleton {
  String _id = "";
  String get id {
    return _id;
  }

  bool isfromConstructor;
  final String timetableName;
  final String objective;
  final DateTime startDate;
  final DateTime endDate;
  final int maximumNumber_frames;
  bool isExpired = false;
  bool isprivate;
  bool isRoutine;
  List<String> row = [];
  List<String> column = [];
  List<List<Single_work>> body = [];
  Schedule_skeleton(
      {required this.timetableName,
      // required this.id,
      required this.isfromConstructor,
      required this.objective,
      required this.startDate,
      required this.endDate,
      required this.maximumNumber_frames,
      required this.isprivate,
      required this.isRoutine}) {
    if (isfromConstructor) {
      body = _generatebody(startDate, endDate, maximumNumber_frames);
      row = _generateRow(startDate, endDate);
      isExpired = _isExpired(endDate);

      column =
          List.generate(maximumNumber_frames, (index) => "work #${index + 1}");
    }
  }

  List<List<Single_work>> _generatebody(
      DateTime startDate, DateTime endDate, int maximumNumber_frames) {
    return List.generate(
        endDate.difference(startDate).inDays,
        (index) => List.generate(
            maximumNumber_frames,
            (index) => Single_work(
                name: "enter work title", description: "enter description")));
  }

  static bool _isExpired(DateTime endDate) {
    DateTime now = DateTime.now();
    return now.isAfter(endDate);
  }

  List<String> _generateRow(DateTime startDate, DateTime endDate) {
    return List.generate(endDate.difference(startDate).inDays,
        (index) => formatdate(index, startDate));
  }

  String formatdate(int day_index, DateTime startDate) {
    List<String> months = [
      "",
      "jan",
      "feb",
      "mar",
      "apr",
      "may",
      "jun",
      "jul",
      "aug",
      "sep",
      "oct",
      "nov",
      "dec"
    ];
    DateTime newdate = startDate.add(Duration(days: day_index));
    return '${newdate.day},${months[newdate.month - 1]}';
  }

  Map<String, dynamic> tojson() {
    return {
      // "id": id,
      "timetableName": timetableName,
      "objective": objective,
      'startDate': startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      'maximumNumber_frames': maximumNumber_frames,
      "isprivate": isprivate.toString(),
      // "isExpired": isExpired.toString(),
      "isRoutine": isRoutine.toString(),
      "row": json.encode(row),
      "column": json.encode(column),
      'body': json
          .encode(body.map((e) => e.map((e2) => e2.tojson()).toList()).toList())
    };
  }

  static Schedule_skeleton fromjson(Map<String, dynamic> map) {
    final schedule_skeleton = Schedule_skeleton(
        timetableName: map['timetableName'],
        // id: id,
        isfromConstructor: false,
        objective: map['objective'],
        startDate: DateTime.parse(map['startDate']),
        endDate: DateTime.parse(map['endDate']),
        maximumNumber_frames: map['maximumNumber_frames'],
        isprivate: map['isprivate'] == "true" ? true : false,
        isRoutine: map['isRoutine'] == "true" ? true : false);
    schedule_skeleton._id = map['id'];
    List<List<Map<String, dynamic>>> decodedbody = json.decode(map['body']);
    List<List<Single_work>> regetedbody = decodedbody
        .map((e) => e.map((sw) => Single_work.fromjson(sw)).toList())
        .toList();
    schedule_skeleton.body = regetedbody;
    // schedule_skeleton.isExpired = map['isExpired'] == "true" ? true : false;
    schedule_skeleton.column = json.decode(map['column']);
    schedule_skeleton.isExpired = _isExpired(DateTime.parse(map['endDate']));

    schedule_skeleton.row = json.decode(map['row']);
    return schedule_skeleton;
  }
}
