class ScheduleClass {
  String scheduleDocId = '';
  String outletId = '';
  dynamic schedule = Map<String, dynamic>;
  // List<DateClass> schedule = [];

  ScheduleClass({
    required this.scheduleDocId,
    required this.outletId,
    required this.schedule,
  });
}

class DateTimeClass {
  String date = '';
  int start = 0;
  int end = 0;
  DateTimeClass({required this.date, required this.start, required this.end});

  // factory DateTimeClass.fromjson(Map<String, dynamic> json) {
  //   return DateTimeClass(start: json['start'] as int, end: json['end'] as int);
  // }
}
