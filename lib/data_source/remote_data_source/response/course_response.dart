import 'package:batch_student_objbox_api/model/course.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CourseResponse {
  bool? success;
  String? message;
  List<Course>? data;

  CourseResponse({this.success, this.message, this.data});

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((e) => Course.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
      };
}
