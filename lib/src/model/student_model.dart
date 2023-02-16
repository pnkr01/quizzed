import 'package:quiz/src/db/local/local_db.dart';

class Student {
  String? sId;
  String? regdNo;
  String? email;
  String? name;
  String? gender;
  String? primaryPhone;
  List<String>? otherPhones;
  int? semester;
  String? branch;
  String? admissionYear;
  String? section;
  String? dateOfBirth;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  Student({
    this.sId,
    required this.regdNo,
    this.email,
    required this.name,
    this.gender,
    this.primaryPhone,
    this.otherPhones,
    this.semester,
    this.branch,
    this.admissionYear,
    this.section,
    this.dateOfBirth,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  Student.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "Unknown";
    regdNo = json['regdNo'] ?? "Unknown";
    email = json['email'] ?? "Unknown";
    name = json['name'] ?? "Unknown";
    gender = json['gender'] ?? "Unknown";
    primaryPhone = json['primaryPhone'] ?? "Unknown";
    otherPhones = json['otherPhones'].cast<String>() ?? "Unknown";
    semester = json['semester'] ?? 0;
    branch = json['branch'] ?? '0';
    admissionYear = json['admissionYear'] ?? '0';
    section = json['section'] ?? '0';
    dateOfBirth = json['dateOfBirth'] ?? 'Unknown';
    status = json['status'] ?? 'Unknown';
    createdAt = json['created_at'] ?? "Unknown";
    updatedAt = json['updated_at'] ?? "Unknown";
    type = json['type'] ?? "Unknown";

    LocalDB.saveStudentModel(name ?? "Unknown", regdNo ?? "Unknown");

    // sharedPreferences.setString('name', name ?? "");
    // sharedPreferences.setString('regdNo', regdNo ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['regdNo'] = regdNo;
    data['email'] = email;
    data['name'] = name;
    data['gender'] = gender;
    data['primaryPhone'] = primaryPhone;
    data['otherPhones'] = otherPhones;
    data['semester'] = semester;
    data['branch'] = branch;
    data['admissionYear'] = admissionYear;
    data['section'] = section;
    data['dateOfBirth'] = dateOfBirth;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    return data;
  }
}
