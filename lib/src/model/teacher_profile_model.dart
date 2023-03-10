class TeacherProfileModel {
  String? RegdNo;
  String? Email;
  String? Name;
  String? Phone;
  //List? subjects;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  TeacherProfileModel({
    required this.RegdNo,
    required this.Email,
    required this.Name,
    required this.Phone,
    // required this.subjects,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  TeacherProfileModel.fromJson(Map<String, dynamic> json) {
    RegdNo = json['regdNo'] ?? "Unknown";
    Email = json['email'] ?? "Unknown";
    Name = json['name'] ?? "Unknown";
    Phone = json['primaryPhone'] ?? "Unknown";
    // if (json['subjects'] != null) {
    //   subjects = <Null>[];
    //   json['subjects'].forEach((v) {
    //     subjects.add(void.fromJson(v));
    //   });
    // }
    status = json['status'] ?? "Unknown";
    createdAt = json['created_at'] ?? "Unknown";
    updatedAt = json['updated_at'] ?? "Unknown";
    type = json['type'] ?? "Unknown";
  }
}
