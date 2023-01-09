import 'package:batch_student_objbox_api/model/batch.dart';
import 'package:batch_student_objbox_api/model/course.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

@JsonSerializable()
@Entity()
class Student {
  @Id(assignable: true)
  int stdId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? studentId;
  String? fname;
  String? lname;
  String? username;
  String? password;

  final batch = ToOne<Batch>();
  final course = ToMany<Course>();

  Student({
    this.stdId = 0,
    this.studentId,
    this.fname,
    this.lname,
    this.username,
    this.password,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['_id'],
      fname: json['fname'],
      lname: json['lname'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': studentId,
        'fname': fname,
        'lname': lname,
        'username': username,
        'password': password,
      };
}
