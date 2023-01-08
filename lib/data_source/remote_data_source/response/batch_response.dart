import 'package:batch_student_objbox_api/model/batch.dart';

class BatchResponse {
  bool? success;
  String? message;
  List<Batch>? data;

  BatchResponse({this.success, this.message, this.data});

  BatchResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Batch>[];
      json['data'].forEach((v) {
        data!.add(Batch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
