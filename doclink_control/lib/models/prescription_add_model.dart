class PrescriptionModel {
  String? uid;
  final String drug;
  final String usageDuration;
  final String duration;
  final String remarks;
  PrescriptionModel(
      {this.uid,
      required this.drug,
      required this.usageDuration,
      required this.duration,
      required this.remarks});

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'drug': drug,
      'usageuDration': usageDuration,
      'duration': duration,
      'remarks': remarks,
    };
  }

  static PrescriptionModel fromJson(Map<String, dynamic> json) =>
      PrescriptionModel(
          uid: json['id'],
          drug: json['drug'],
          usageDuration: json['usageuDration'],
          duration: json['duration'],
          remarks: json['remarks']);
}
