class ResultModal {
  int? statusCode;
  String? message;
  List<Null>? errors;
  Data? data;

  ResultModal({this.statusCode, this.message, this.errors, this.data});

  ResultModal.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    // if (json['errors'] != null) {
    //   errors = <Null>[];
    //   json['errors'].forEach((v) {
    //     errors!.add(new Null.fromJson(v));
    //   });
    // }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    // if (this.errors != null) {
    //   data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    // }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? marksObtained;
  int? totalMarks;

  Data({this.marksObtained, this.totalMarks});

  Data.fromJson(Map<String, dynamic> json) {
    marksObtained = json['marksObtained'];
    totalMarks = json['totalMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marksObtained'] = this.marksObtained;
    data['totalMarks'] = this.totalMarks;
    return data;
  }
}
