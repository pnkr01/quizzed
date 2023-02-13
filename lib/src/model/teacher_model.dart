class Teacher {
  String? sId;
  String? regdNo;
  String? email;
  String? name;
  String? primaryPhone;
  //List? subjects;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  Teacher({
    required this.sId,
    required this.regdNo,
    required this.email,
    required this.name,
    required this.primaryPhone,
    // required this.subjects,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  Teacher.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "Unknown";
    regdNo = json['regdNo'] ?? "Unknown";
    email = json['email'] ?? "Unknown";
    name = json['name'] ?? "Unknown";
    primaryPhone = json['primaryPhone'] ?? "Unknown";
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['regdNo'] = regdNo;
    data['email'] = email;
    data['name'] = name;
    data['primaryPhone'] = primaryPhone;
    // if (subjects != null) {
    //   data['subjects'] = subjects.map((v) => v.toJson()).toList();
    // }
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    return data;
  }
}
