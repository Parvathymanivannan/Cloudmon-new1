class Data {
  final String name;
  final int alarms;
  final String alarm_status;
  // final int id;

  // final String title;

  Data({
    required this.name,
    required this.alarms,
    required this.alarm_status,
    // required this.id
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      name: json['name'],
      alarms: json['alarms'],
      alarm_status: json["alarm_status"],
      // id: json["_id"]

      // title: json['title'],
    );
  }
}

class Data2 {
  final String name;
  final int alarms;
  final String alarm_status;
  // final int id;

  // final String title;

  Data2({
    required this.name,
    required this.alarms,
    required this.alarm_status,
    // required this.id
  });

  factory Data2.fromJson(Map<dynamic, dynamic> json) {
    return Data2(
      name: json['name'],
      alarms: json['alarms'],
      alarm_status: json["alarm_status"],
      // id: json["_id"]

      // title: json['title'],
    );
  }
}
