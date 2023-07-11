class PrescriptionModel {
  String? uid;
  final String drug;
  final String usageDuration;
  final String duration;
  final String date;
  final String remarks;
  final String? userid;

  PrescriptionModel(
      {this.uid,
      this.userid,
      required this.date,
      required this.drug,
      required this.usageDuration,
      required this.duration,
      required this.remarks});

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'id': uid,
      'drug': drug,
      'usageuDration': usageDuration,
      'duration': duration,
      'remarks': remarks,
      "userId": userid,
    };
  }

  static PrescriptionModel fromJson(Map<String, dynamic> json) =>
      PrescriptionModel(
        date: json['date'],
        uid: json['id'],
        drug: json['drug'],
        usageDuration: json['usageuDration'],
        duration: json['duration'],
        remarks: json['remarks'],
        userid: json['userid'],
      );
}
