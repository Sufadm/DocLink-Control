class AddDetailModel {
  String? uid;
  final String fee;
  final String date;
  final String startTime;
  final String endTime;
  final String timePerPerson;
  AddDetailModel({
    required this.fee,
    this.uid,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.timePerPerson,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'fee': fee,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'timePerPerson': timePerPerson,
    };
  }

  static AddDetailModel fromJson(Map<String, dynamic> json) => AddDetailModel(
        uid: json['id'],
        fee: json['fee'],
        date: json['date'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        timePerPerson: json['timePerPerson'],
      );
}
//?Time Details-----------------------------------------------------------------


