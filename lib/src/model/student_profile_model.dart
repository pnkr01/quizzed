// ignore: camel_case_types
class StudentProfileModel {
  String? regdNo;
  String? email;
  String? name;
  String? gender;
  String? primaryPhone;
  int? semester;
  String? branch;
  String? admissionYear;
  String? section;
  String? dateOfBirth;
  String? status;
  String? createdAt;
  String? updatedAt;

  StudentProfileModel({
    this.regdNo,
    this.email,
    this.name,
    this.gender,
    this.primaryPhone,
    this.semester,
    this.branch,
    this.admissionYear,
    this.section,
    this.dateOfBirth,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    regdNo = json['regdNo'] ?? "not given";
    email = json['email'] ?? "not given";
    name = json['name'] ?? "not given";
    gender = json['gender'] ?? "not given";
    primaryPhone = json['primaryPhone'] ?? "not given";
    semester = json['semester'];
    branch = json['branch'] ?? "not given";
    admissionYear = json['admissionYear'] ?? "not given";
    section = json['section'] ?? "not given";
    dateOfBirth = json['dateOfBirth'] ?? "not given";
    status = json['status'] ?? "not given";
    createdAt = json['created_at'] ?? "not given";
    updatedAt = json['updated_at'] ?? "not given";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regdNo'] = regdNo;
    data['email'] = email;
    data['name'] = name;
    data['gender'] = gender;
    data['primaryPhone'] = primaryPhone;
    data['semester'] = semester;
    data['branch'] = branch;
    data['admissionYear'] = admissionYear;
    data['section'] = section;
    data['dateOfBirth'] = dateOfBirth;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
