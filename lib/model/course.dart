import 'package:batch_student_objbox_api/model/student.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Course {
  // @Id(assignable: true)
  @Id(assignable: true)
  int id;

  @Unique()
  @Index()
  String courseId;
  String courseName;

  @Backlink()
  final student = ToMany<Student>();

  Course(this.courseId, this.courseName, {this.id = 0});

  // Course(this.courseId, this.courseName);
}
