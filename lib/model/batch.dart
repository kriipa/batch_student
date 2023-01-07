import 'package:batch_student_objbox_api/model/student.dart';
import 'package:objectbox/objectbox.dart';

//flutter pub run build_runner build  --delete-conflicting-outputs
@Entity()
class Batch {
  // @Id(assignable: true)
  @Id(assignable: true)
  int batchId;
  String batchName;

  @Backlink()
  final student = ToMany<Student>();

  //Constructor
  Batch(this.batchName, {this.batchId = 0});
  // Batch(this.batchId, this.batchName);
}
