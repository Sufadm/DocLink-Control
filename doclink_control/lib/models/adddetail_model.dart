class AddDetailModel {
  String? uid;
  final String place;
  final String time;
  final String fee;

  AddDetailModel(
      {required this.fee, this.uid, required this.place, required this.time});
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'place': place,
      'time': time,
      'fee': fee,
    };
  }

  static AddDetailModel fromJson(Map<String, dynamic> json) => AddDetailModel(
      place: json['place'],
      time: json['time'],
      uid: json['id'],
      fee: json['fee']);
}
